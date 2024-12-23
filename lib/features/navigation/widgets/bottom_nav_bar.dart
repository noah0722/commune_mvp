// #File: lib/features/navigation/widgets/bottom_nav_bar.dart
import 'package:commune/core/models/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:commune/core/constants/app_strings.dart';
import 'package:commune/core/providers/auth_provider.dart';
import 'package:commune/features/notification/providers/notification_provider.dart';

final selectedNavIndexProvider = StateProvider<int>((ref) => 0);

class BottomNavBar extends ConsumerWidget {
  const BottomNavBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedIndex = ref.watch(selectedNavIndexProvider);
    final unreadCount = ref.watch(unreadNotificationCountProvider).value ?? 0;
    final user = ref.watch(authStateProvider).value;

    return BottomNavigationBar(
      currentIndex: selectedIndex,
      type: BottomNavigationBarType.fixed,
      items: [
        const BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: AppStrings.home,
        ),
        const BottomNavigationBarItem(
          icon: Icon(Icons.people),
          label: AppStrings.mu,
        ),
        BottomNavigationBarItem(
          icon: Container(
            height: 40,
            width: 40,
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.add,
              color: Colors.white,
            ),
          ),
          label: AppStrings.write,
        ),
        const BottomNavigationBarItem(
          icon: Icon(Icons.emoji_events),
          label: AppStrings.ranking,
        ),
        BottomNavigationBarItem(
          icon: Stack(
            clipBehavior: Clip.none,
            children: [
              const Icon(Icons.notifications),
              if (unreadCount > 0)
                Positioned(
                  right: -6,
                  top: -3,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.error,
                      shape: BoxShape.circle,
                    ),
                    constraints: const BoxConstraints(
                      minWidth: 16,
                      minHeight: 16,
                    ),
                    child: Text(
                      unreadCount > 99 ? '99+' : unreadCount.toString(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
            ],
          ),
          label: AppStrings.notification,
        ),
      ],
      onTap: (index) => _handleNavigation(context, ref, index, user),
    );
  }

  void _handleNavigation(
    BuildContext context,
    WidgetRef ref,
    int index,
    User? user,
  ) {
    // Write post requires login
    if (index == 2 && user == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text(AppStrings.loginRequired),
          action: SnackBarAction(
            label: AppStrings.login,
            onPressed: () {
              Navigator.pushNamed(context, '/login');
            },
          ),
          behavior: SnackBarBehavior.floating,
          showCloseIcon: true,
        ),
      );
      return;
    }

    ref.read(selectedNavIndexProvider.notifier).state = index;

    switch (index) {
      case 0:
        Navigator.pushReplacementNamed(context, '/');
        break;
      case 1:
        Navigator.pushReplacementNamed(context, '/mu');
        break;
      case 2:
        Navigator.pushNamed(context, '/write');
        break;
      case 3:
        Navigator.pushReplacementNamed(context, '/ranking');
        break;
      case 4:
        Navigator.pushReplacementNamed(context, '/notifications');
        break;
    }
  }
}