import 'package:commune/core/models/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:commune/features/notification/widgets/notification_list.dart';
import 'package:commune/features/notification/providers/notification_provider.dart';
import 'package:commune/core/providers/auth_provider.dart'; // Add this import

class NotificationView extends ConsumerWidget {
  const NotificationView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(authStateProvider).value; // Get the current user

    return Scaffold(
      appBar: AppBar(
        title: const Text('알림'),
        actions: [
          if (user != null) // Only show if user is logged in
            IconButton(
              icon: const Icon(Icons.done_all),
              onPressed: () {
                ref.read(notificationServiceProvider).markAllAsRead(user.id);
              },
            ),
        ],
      ),
      body: const NotificationList(),
    );
  }
}
