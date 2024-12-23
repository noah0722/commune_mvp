import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:commune/features/notification/providers/notification_provider.dart';
import 'package:commune/features/notification/widgets/notification_tile.dart';
import 'package:commune/core/widgets/error_view.dart';
import 'package:commune/core/widgets/loading_view.dart';

class NotificationList extends ConsumerWidget {
  const NotificationList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notificationsState = ref.watch(notificationsProvider);

    return RefreshIndicator(
      onRefresh: () {
        ref.invalidate(notificationsProvider);
        return Future.value();
      },
      child: notificationsState.when(
        data: (notifications) => notifications.isEmpty
            ? Center(
                child: Text(
                  '새로운 알림이 없어요',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: Colors.grey,
                      ),
                ),
              )
            : ListView.builder(
                itemCount: notifications.length,
                itemBuilder: (context, index) {
                  return NotificationTile(
                    notification: notifications[index],
                  );
                },
              ),
        loading: () => const LoadingView(),
        error: (error, stack) => ErrorView(
          message: error.toString(),
          onRetry: () => ref.invalidate(notificationsProvider),
        ),
      ),
    );
  }
}
