import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:commune/features/mu/widgets/mu_discussion_tab.dart';
import 'package:commune/features/mu/widgets/mu_info_tab.dart';
import 'package:commune/features/mu/widgets/mu_official_tab.dart';
import 'package:commune/features/mu/providers/mu_tab_provider.dart';

class MuTabView extends ConsumerStatefulWidget {
  const MuTabView({
    super.key,
    required this.muId,
  });
  final String muId;

  @override
  ConsumerState<MuTabView> createState() => _MuTabViewState();
}

class _MuTabViewState extends ConsumerState<MuTabView>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(_handleTabChange);
  }

  @override
  void dispose() {
    _tabController.removeListener(_handleTabChange);
    _tabController.dispose();
    super.dispose();
  }

  void _handleTabChange() {
    if (!_tabController.indexIsChanging) {
      ref.read(selectedMuTabProvider.notifier).state =
          MuTab.values[_tabController.index];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TabBar(
          controller: _tabController,
          labelColor: Theme.of(context).primaryColor,
          unselectedLabelColor: Theme.of(context).textTheme.bodyMedium?.color,
          indicatorColor: Theme.of(context).primaryColor,
          tabs: const [
            Tab(text: '토론'),
            Tab(text: '정보'),
            Tab(text: '공식'),
          ],
        ),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: [
              MuDiscussionTab(muId: widget.muId),
              MuInfoTab(muId: widget.muId),
              const MuOfficialTab(),
            ],
          ),
        ),
      ],
    );
  }
}
