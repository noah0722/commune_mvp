import 'package:commune/core/models/commore_transaction.dart';
import 'package:commune/core/services/commore_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:commune/core/providers/auth_provider.dart';
import 'package:commune/features/mu/providers/mu_provider.dart';

class JoinMuButton extends ConsumerWidget {
  const JoinMuButton({
    super.key,
    required this.muId,
  });
  final String muId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(authStateProvider).value;

    if (user == null) {
      return ElevatedButton(
        onPressed: () => Navigator.pushNamed(context, '/login'),
        child: const Text('가입'),
      );
    }

    final hasJoined = user.joinedMus.contains(muId);

    return ElevatedButton(
      onPressed: () async {
        try {
          if (hasJoined) {
            // Leave mu
            await ref.read(muServiceProvider).leaveMu(user.id, muId);
            if (context.mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('뮤를 탈퇴했어요')),
              );
            }
          } else {
            // Join mu
            await ref.read(muServiceProvider).joinMu(user.id, muId);
            await ref.read(commoreServiceProvider).awardPoints(
                  userId: user.id,
                  type: CommoreActionType.muJoin,
                  amount: 50,
                  relatedId: muId,
                );
            if (context.mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('뮤에 가입하신 것을 축하해요! 50코몰이 지급되었어요'),
                ),
              );
            }
          }
        } catch (e) {
          if (context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(e.toString()),
                backgroundColor: Theme.of(context).colorScheme.error,
              ),
            );
          }
        }
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: hasJoined ? Colors.grey : null,
      ),
      child: Text(hasJoined ? '탈퇴' : '가입'),
    );
  }
}
