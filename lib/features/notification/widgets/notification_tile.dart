import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:commune/core/models/notification.dart' as model;
import 'package:commune/core/utils/date_utils.dart' as date_utils;
import 'package:cached_network_image/cached_network_image.dart';

class NotificationTile extends ConsumerWidget {
  const NotificationTile({
    super.key,
    required this.notification,
  });
  final model.Notification notification; // Changed to use model.Notification

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Dismissible(
      key: Key(notification.id),
      direction: DismissDirection.endToStart,
      background: Container(
        color: Theme.of(context).colorScheme.error,
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 16),
        child: const Icon(
          Icons.delete,
          color: Colors.white,
        ),
      ),
      onDismissed: (_) {
        // Delete notification
      },
      child: ListTile(
        leading: _buildLeadingIcon(context),
        title: Text(notification.message),
        subtitle: Text(
          date_utils.DateUtils.getTimeAgo(
              notification.createdAt), // Use date_utils prefix
          style: Theme.of(context).textTheme.bodySmall,
        ),
        trailing: notification.isRead
            ? null
            : Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Theme.of(context).primaryColor,
                ),
              ),
        tileColor: notification.isRead
            ? null
            : Theme.of(context).primaryColor.withOpacity(0.05),
        onTap: () {
          // Handle notification tap
        },
      ),
    );
  }

  Widget _buildLeadingIcon(BuildContext context) {
    if (notification.imageUrl != null) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: CachedNetworkImage(
          imageUrl: notification.imageUrl!,
          width: 48,
          height: 48,
          fit: BoxFit.cover,
          placeholder: (context, url) => Container(
            color: Theme.of(context).colorScheme.surfaceContainerHighest,
          ),
          errorWidget: (context, url, error) => Container(
            color: Theme.of(context).colorScheme.surfaceContainerHighest,
            child: const Icon(Icons.error),
          ),
        ),
      );
    }

    late IconData icon;
    late Color color;

    switch (notification.type) {
      case model.NotificationType.newPost:
        icon = Icons.article;
        color = Colors.blue;
        break;
      case model.NotificationType.newComment:
      case model.NotificationType.newReply:
        icon = Icons.comment;
        color = Colors.green;
        break;
      case model.NotificationType.commoreReceived:
        icon = Icons.currency_exchange;
        color = Colors.orange;
        break;
      case model.NotificationType.muJoined:
        icon = Icons.group_add;
        color = Colors.purple;
        break;
      case model.NotificationType.mention:
        icon = Icons.alternate_email;
        color = Colors.blue;
        break;
      case model.NotificationType.postReaction:
      case model.NotificationType.commentReaction:
        icon = Icons.thumb_up;
        color = Colors.red;
        break;
    }

    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color.withOpacity(0.1),
      ),
      child: Icon(
        icon,
        color: color,
      ),
    );
  }
}
