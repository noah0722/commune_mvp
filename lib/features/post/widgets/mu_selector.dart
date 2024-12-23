// #File: lib/features/post/widgets/mu_selector.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:commune/core/models/mu.dart';
import 'package:commune/features/post/providers/mu_selector_provider.dart';
import 'package:commune/core/widgets/mu_avatar.dart';
import 'package:commune/core/constants/app_strings.dart';

class MuSelector extends ConsumerStatefulWidget {
  const MuSelector({super.key});

  @override
  ConsumerState<MuSelector> createState() => _MuSelectorState();
}

class _MuSelectorState extends ConsumerState<MuSelector> {
  final _searchController = TextEditingController();
  bool _isOpen = false;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final selectedMu = ref.watch(selectedMuProvider);
    final searchResults = ref.watch(muSearchResultsProvider);
    final recentMus = ref.watch(recentMusProvider).value ?? [];
    final myMus = ref.watch(myMusProvider).value ?? [];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              _isOpen = !_isOpen;
            });
            if (!_isOpen) {
              _searchController.clear();
            }
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              border: Border.all(color: Theme.of(context).dividerColor),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                if (selectedMu != null) ...[
                  MuAvatar(mu: selectedMu, radius: 16),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      selectedMu.name,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ),
                ] else ...[
                  Expanded(
                    child: Text(
                      AppStrings.selectMu,
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: Theme.of(context).hintColor,
                      ),
                    ),
                  ),
                ],
                Icon(
                  _isOpen ? Icons.expand_less : Icons.expand_more,
                  color: Theme.of(context).iconTheme.color,
                ),
              ],
            ),
          ),
        ),
        if (_isOpen) ...[
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              border: Border.all(color: Theme.of(context).dividerColor),
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText: '뮤 검색',
                    prefixIcon: const Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onChanged: (value) {
                    ref.read(muSearchQueryProvider.notifier).state = value;
                  },
                ),
                const SizedBox(height: 16),
                if (_searchController.text.isEmpty) ...[
                  if (recentMus.isNotEmpty) ...[
                    _buildSectionTitle('최근 방문 뮤'),
                    const SizedBox(height: 8),
                    _buildMuList(recentMus.take(3).toList()),
                    const SizedBox(height: 16),
                  ],
                  if (myMus.isNotEmpty) ...[
                    _buildSectionTitle('나의 뮤'),
                    const SizedBox(height: 8),
                    _buildMuList(myMus.take(3).toList()),
                  ],
                ] else ...[
                  searchResults.when(
                    data: (mus) => _buildMuList(mus),
                    loading: () => const Center(
                      child: CircularProgressIndicator(),
                    ),
                    error: (error, stack) => Center(
                      child: Text(error.toString()),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: Theme.of(context).textTheme.titleSmall?.copyWith(
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildMuList(List<Mu> mus) {
    return Column(
      children: mus.map((mu) => _buildMuItem(mu)).toList(),
    );
  }

  Widget _buildMuItem(Mu mu) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: MuAvatar(mu: mu),
      title: Text(mu.name),
      onTap: () {
        ref.read(selectedMuProvider.notifier).state = mu;
        setState(() {
          _isOpen = false;
        });
        _searchController.clear();
      },
    );
  }
}