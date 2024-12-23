import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:commune/core/constants/app_strings.dart';
import 'package:commune/features/home/providers/feed_filter_provider.dart';

class FeedFilterBar extends ConsumerWidget {
  const FeedFilterBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final algorithm = ref.watch(feedAlgorithmProvider);
    final postType = ref.watch(postTypeFilterProvider);
    final muType = ref.watch(muTypeFilterProvider);

    return Column(
      children: [
        Container(
          height: 48,
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: Theme.of(context).dividerColor,
              ),
            ),
          ),
          child: Row(
            children: [
              _buildAlgorithmTab(
                context,
                ref,
                AppStrings.best,
                FeedAlgorithm.best,
                algorithm,
              ),
              _buildAlgorithmTab(
                context,
                ref,
                AppStrings.latest,
                FeedAlgorithm.latest,
                algorithm,
              ),
              _buildAlgorithmTab(
                context,
                ref,
                AppStrings.following,
                FeedAlgorithm.following,
                algorithm,
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Expanded(
                child: _buildFilterDropdown(
                  AppStrings.postType,
                  postType,
                  PostTypeFilter.values,
                  (value) =>
                      ref.read(postTypeFilterProvider.notifier).state = value,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _buildFilterDropdown(
                  AppStrings.muType,
                  muType,
                  MuTypeFilter.values,
                  (value) =>
                      ref.read(muTypeFilterProvider.notifier).state = value,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildAlgorithmTab(
    BuildContext context,
    WidgetRef ref,
    String label,
    FeedAlgorithm algorithm,
    FeedAlgorithm selectedAlgorithm,
  ) {
    final isSelected = algorithm == selectedAlgorithm;
    final theme = Theme.of(context);

    return Expanded(
      child: InkWell(
        onTap: () => ref.read(feedAlgorithmProvider.notifier).state = algorithm,
        child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: isSelected ? theme.primaryColor : Colors.transparent,
                width: 2,
              ),
            ),
          ),
          child: Text(
            label,
            style: TextStyle(
              color: isSelected
                  ? theme.primaryColor
                  : theme.textTheme.bodyMedium?.color,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFilterDropdown<T>(
    String hint,
    T selectedValue,
    List<T> items,
    void Function(T) onChanged,
  ) {
    return Container(
      height: 40,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(20),
      ),
      child: DropdownButton<T>(
        value: selectedValue,
        isExpanded: true,
        underline: const SizedBox(),
        icon: const Icon(Icons.keyboard_arrow_down),
        borderRadius: BorderRadius.circular(8),
        hint: Text(hint),
        items: items.map((item) {
          return DropdownMenuItem<T>(
            value: item,
            child: Text(_getFilterLabel(item)),
          );
        }).toList(),
        onChanged: (value) {
          if (value != null) {
            onChanged(value);
          }
        },
      ),
    );
  }

  String _getFilterLabel(dynamic value) {
    if (value is PostTypeFilter) {
      switch (value) {
        case PostTypeFilter.all:
          return '전체';
        case PostTypeFilter.discussion:
          return '토론';
        case PostTypeFilter.official:
          return '공식';
      }
    }
    if (value is MuTypeFilter) {
      switch (value) {
        case MuTypeFilter.all:
          return '전체';
        case MuTypeFilter.politicsParty:
          return '정치인 & 정당';
        case MuTypeFilter.newsPoll:
          return '뉴스 & 여론조사';
        case MuTypeFilter.election:
          return '선거';
      }
    }
    return value.toString();
  }
}
