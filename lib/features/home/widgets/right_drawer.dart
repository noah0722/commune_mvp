import 'package:commune/core/models/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:commune/core/providers/auth_provider.dart';
import 'package:commune/core/constants/app_strings.dart';
import 'package:commune/features/auth/widgets/profile_header.dart';
import 'package:commune/features/official/widgets/official_menu.dart';
import 'package:go_router/go_router.dart';

class RightDrawer extends ConsumerWidget {
  const RightDrawer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authStateProvider);

    return Drawer(
      child: authState.when(
        data: (user) {
          if (user == null) {
            return _buildLoginMenu(context);
          }
          return _buildUserMenu(context, ref, user); // Pass ref here
        },
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
        error: (error, stack) => Center(
          child: Text(error.toString()),
        ),
      ),
    );
  }

  Widget _buildLoginMenu(BuildContext context) {
    return ListView(
      children: [
        DrawerHeader(
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
          ),
          child: Center(
            child: Text(
              AppStrings.appName,
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    color: Colors.white,
                  ),
            ),
          ),
        ),
        ListTile(
          leading: const Icon(Icons.login),
          title: const Text(AppStrings.login),
          onTap: () {
            Navigator.pop(context); // Close drawer
            GoRouter.of(context).go('/login'); // Use GoRouter's navigation
          },
        ),
      ],
    );
  }

  Widget _buildUserMenu(BuildContext context, WidgetRef ref, User user) {
    // Added ref parameter
    return ListView(
      children: [
        ProfileHeader(user: user),
        ListTile(
          leading: const Icon(Icons.person),
          title: const Text(AppStrings.myInfo),
          onTap: () => Navigator.pushNamed(context, '/profile'),
        ),
        ListTile(
          leading: const Icon(Icons.currency_exchange),
          title: const Text(AppStrings.myCommore),
          onTap: () => Navigator.pushNamed(context, '/commore'),
        ),
        ListTile(
          leading: const Icon(Icons.article),
          title: const Text(AppStrings.myPosts),
          onTap: () => Navigator.pushNamed(context, '/my-posts'),
        ),
        if (!user.isAdmin) ...[
          const Divider(),
          const OfficialMenu(),
        ],
        ListTile(
          leading: const Icon(Icons.campaign),
          title: const Text(AppStrings.advertise),
          onTap: () => Navigator.pushNamed(context, '/advertise'),
        ),
        if (user.isAdmin)
          ListTile(
            leading: const Icon(Icons.admin_panel_settings),
            title: const Text(AppStrings.adminMode),
            onTap: () => Navigator.pushNamed(context, '/admin'),
          ),
        const Divider(),
        ListTile(
          leading: const Icon(Icons.logout),
          title: const Text(AppStrings.logout),
          onTap: () async {
            final confirmed = await showDialog<bool>(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text(AppStrings.logout),
                content: const Text('로그아웃 하시겠어요?'),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context, false),
                    child: const Text(AppStrings.cancel),
                  ),
                  TextButton(
                    onPressed: () => Navigator.pop(context, true),
                    child: const Text(AppStrings.confirm),
                  ),
                ],
              ),
            );

            if (confirmed ?? false) {
              await ref.read(authProvider).signOut(); // Use the passed ref
              if (context.mounted) {
                Navigator.pushReplacementNamed(context, '/');
              }
            }
          },
        ),
      ],
    );
  }
}
