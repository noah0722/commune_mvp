import 'package:commune/core/models/mu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:commune/core/constants/app_strings.dart';
import 'package:commune/features/home/providers/mu_drawer_provider.dart';
import 'package:commune/features/mu/widgets/mu_list_tile.dart';
import 'package:commune/core/widgets/error_view.dart';
import 'package:commune/core/widgets/loading_view.dart';

class LeftDrawer extends ConsumerWidget {
  const LeftDrawer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Drawer(
      child: SafeArea(
        child: Column(
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
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildMuSection(
                      context: context,
                      title: AppStrings.recentMus,
                      provider: recentMusProvider,
                      emptyMessage: AppStrings.noMu,
                      onSeeMore: () => Navigator.pushNamed(context, '/mu'),
                    ),
                    _buildMuSection(
                      context: context,
                      title: AppStrings.myMus,
                      provider: myMusProvider,
                      emptyMessage: AppStrings.noMyMu,
                      onSeeMore: () => Navigator.pushNamed(context, '/mu'),
                    ),
                    _buildMuSection(
                      context: context,
                      title: AppStrings.allMus,
                      provider: popularMusProvider,
                      onSeeMore: () => Navigator.pushNamed(context, '/mu'),
                    ),
                  ],
                ),
              ),
            ),
            const Divider(height: 1),
            ListTile(
              title: const Text(AppStrings.terms),
              onTap: () => Navigator.pushNamed(context, '/terms'),
            ),
            ListTile(
              title: const Text(AppStrings.privacy),
              onTap: () => Navigator.pushNamed(context, '/privacy'),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                AppStrings.copyright,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Colors.grey,
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMuSection({
    required BuildContext context,
    required String title,
    required provider,
    String? emptyMessage,
    VoidCallback? onSeeMore,
  }) {
    return Consumer(
      builder: (context, ref, child) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                title,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ),
            _buildMusSection(context, ref, provider, emptyMessage, onSeeMore),
            const Divider(),
          ],
        );
      },
    );
  }

  Widget _buildMusSection(
    BuildContext context,
    WidgetRef ref,
    provider,
    String? emptyMessage,
    VoidCallback? onSeeMore,
  ) {
    final musState = ref.watch(provider);

    return musState.when(
      data: (mus) {
        if (mus.isEmpty && emptyMessage != null) {
          return Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              emptyMessage,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.grey,
                  ),
            ),
          );
        }

        return Column(
          children: [
            ...mus.take(3).map((mu) => MuListTile(mu: mu)),
            if (mus.length > 3 && onSeeMore != null)
              ListTile(
                title: const Text('더 보기'),
                trailing: const Icon(Icons.chevron_right),
                onTap: onSeeMore,
              ),
          ],
        );
      },
      loading: () => const SizedBox(
        height: 100,
        child: LoadingView(),
      ),
      error: (error, stack) => SizedBox(
        height: 100,
        child: ErrorView(
          message: error.toString(),
          onRetry: () => ref.invalidate(provider),
        ),
      ),
    );
  }
}
