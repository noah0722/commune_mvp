import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:commune/features/mu/widgets/mu_detail_header.dart';
import 'package:commune/features/mu/widgets/mu_tab_view.dart';
import 'package:commune/core/widgets/error_view.dart';
import 'package:commune/core/widgets/loading_view.dart';
import 'package:commune/features/mu/providers/mu_provider.dart';

class MuDetailView extends ConsumerWidget {
  const MuDetailView({
    super.key,
    required this.muId,
  });
  final String muId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final muState = ref.watch(muProvider(muId));

    return Scaffold(
      body: muState.when(
        data: (mu) {
          if (mu == null) {
            return const ErrorView(
              message: '뮤를 찾을 수 없어요',
            );
          }

          return NestedScrollView(
            headerSliverBuilder: (context, innerBoxIsScrolled) {
              return [
                MuDetailHeader(mu: mu),
              ];
            },
            body: MuTabView(muId: muId),
          );
        },
        loading: () => const LoadingView(),
        error: (error, stack) => ErrorView(
          message: error.toString(),
          onRetry: () => ref.invalidate(muProvider(muId)),
        ),
      ),
    );
  }
}
