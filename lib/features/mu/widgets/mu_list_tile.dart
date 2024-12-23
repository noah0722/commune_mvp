// #File: lib/features/mu/widgets/mu_list_tile.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:commune/core/models/mu.dart';
import 'package:commune/core/widgets/mu_avatar.dart';
import 'package:commune/core/widgets/join_mu_button.dart';

class MuListTile extends ConsumerWidget {
  final Mu mu;
  final bool showJoinButton;
  final VoidCallback? onTap;

  const MuListTile({
    super.key,
    required this.mu,
    this.showJoinButton = true,
    this.onTap,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListTile(
      onTap: onTap ?? () => _navigateToMu(context),
      leading: MuAvatar(mu: mu),
      title: Row(
        children: [
          Expanded(
            child: Text(
              'mu/${mu.name}',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          if (mu.isVerified)
            Padding(
              padding: const EdgeInsets.only(left: 4),
              child: Icon(
                Icons.verified,
                size: 16,
                color: Theme.of(context).primaryColor,
              ),
            ),
        ],
      ),
      subtitle: mu.description.isNotEmpty
          ? Text(
              mu.description,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            )
          : null,
      trailing: showJoinButton
          ? SizedBox(
              width: 72,
              child: JoinMuButton(muId: mu.id),
            )
          : null,
    );
  }

  void _navigateToMu(BuildContext context) {
    Navigator.pushNamed(
      context,
      '/mu/${mu.id}',
    );
  }
}
