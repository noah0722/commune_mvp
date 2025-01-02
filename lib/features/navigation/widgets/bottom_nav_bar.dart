// lib/features/navigation/widgets/bottom_nav_bar.dart
import 'package:commune/core/models/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart'; // Add this import
import 'package:commune/core/constants/app_strings.dart';
import 'package:commune/core/providers/auth_provider.dart';
import 'package:commune/features/notification/providers/notification_provider.dart';

final selectedNavIndexProvider = StateProvider<int>((ref) => 0);

class BottomNavBar extends ConsumerWidget {
  const BottomNavBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedIndex = ref.watch(selectedNavIndexProvider);
    final authState = ref.watch(authStateProvider);

    return authState.when(
      data: (user) => _buildNavBar(context, ref, selectedIndex, user),
      loading: _buildLoadingNavBar,
      error: (_, __) => _buildNavBar(context, ref, selectedIndex, null),
    );
  }

  Widget _buildLoadingNavBar() {
    return BottomNavigationBar(
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: AppStrings.home,
        ),
      ],
    );
  }

  Widget _buildNavBar(
      BuildContext context, WidgetRef ref, int selectedIndex, User? user) {
    final unreadCount = ref.watch(unreadNotificationCountProvider).value ?? 0;

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
              context.go('/login'); // Use GoRouter
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
        context.go('/'); // Use GoRouter
        break;
      case 1:
        context.go('/mu'); // Use GoRouter
        break;
      case 2:
        context.go('/write'); // Use GoRouter
        break;
      case 3:
        context.go('/ranking'); // Use GoRouter
        break;
      case 4:
        context.go('/notifications'); // Use GoRouter
        break;
    }
  }
}
