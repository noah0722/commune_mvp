import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:commune/core/providers/auth_provider.dart';

class WritePostButton extends ConsumerWidget {
  final String muId;

  const WritePostButton({
    super.key,
    required this.muId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(authStateProvider).value;
    
    return OutlinedButton(
      onPressed: () {
        if (user == null) {
          Navigator.pushNamed(context, '/login');
        } else {
          Navigator.pushNamed(
            context, 
            '/write',
            arguments: {'muId': muId},
          );
        }
      },
      style: OutlinedButton.styleFrom(
        foregroundColor: Colors.white,
        side: const BorderSide(color: Colors.white),
      ),
      child: const Text('작성'),
    );
  }
}