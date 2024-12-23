// #File: lib/features/mu/widgets/mu_info_tab.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:commune/core/models/mu.dart';
import 'package:commune/features/mu/providers/mu_provider.dart';

class MuInfoTab extends ConsumerWidget {
  final String muId;

  const MuInfoTab({
    super.key,
    required this.muId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final muAsync = ref.watch(muProvider(muId));

    return muAsync.when(
      data: (mu) {
        if (mu == null) {
          return const Center(
            child: Text('뮤를 찾을 수 없어요'),
          );
        }
        return SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildStatsSection(context, mu),
              const Divider(height: 32),
              _buildInfoSection(
                context,
                title: '정보',
                info: [
                  InfoItem(
                    icon: Icons.location_on,
                    label: '국가',
                    value: mu.country,
                  ),
                  InfoItem(
                    icon: Icons.language,
                    label: '언어',
                    value: mu.language,
                  ),
                  InfoItem(
                    icon: Icons.category,
                    label: '주제',
                    value: '${mu.topicLevel1} > ${mu.topicLevel2}',
                  ),
                ],
              ),
              if (mu.officialWebsite != null) ...[
                const Divider(height: 32),
                _buildInfoSection(
                  context,
                  title: '링크',
                  info: [
                    InfoItem(
                      icon: Icons.link,
                      label: '공식 웹사이트',
                      value: mu.officialWebsite!,
                      isLink: true,
                    ),
                  ],
                ),
              ],
              const Divider(height: 32),
              _buildInfoSection(
                context,
                title: '커뮤니티',
                info: [
                  InfoItem(
                    icon: Icons.people,
                    label: '멤버',
                    value: '${mu.memberCount}명',
                  ),
                  InfoItem(
                    icon: Icons.article,
                    label: '포스트',
                    value: '${mu.postCount}개',
                  ),
                  InfoItem(
                    icon: Icons.calendar_today,
                    label: '개설일',
                    value: _formatDate(mu.createdAt),
                  ),
                ],
              ),
            ],
          ),
        );
      },
      loading: () => const Center(
        child: CircularProgressIndicator(),
      ),
      error: (error, stack) => Center(
        child: Text(error.toString()),
      ),
    );
  }

  Widget _buildStatsSection(BuildContext context, Mu mu) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildStatItem(
          context,
          value: mu.memberCount.toString(),
          label: '멤버',
        ),
        Container(
          height: 40,
          width: 1,
          color: Theme.of(context).dividerColor,
        ),
        _buildStatItem(
          context,
          value: mu.postCount.toString(),
          label: '포스트',
        ),
      ],
    );
  }

  Widget _buildStatItem(
    BuildContext context, {
    required String value,
    required String label,
  }) {
    return Column(
      children: [
        Text(
          value,
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.bold,
            color: Theme.of(context).primaryColor,
          ),
        ),
        Text(
          label,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: Theme.of(context).textTheme.bodySmall?.color,
          ),
        ),
      ],
    );
  }

  Widget _buildInfoSection(
    BuildContext context, {
    required String title,
    required List<InfoItem> info,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        ...info.map((item) => _buildInfoItem(context, item)),
      ],
    );
  }

  Widget _buildInfoItem(BuildContext context, InfoItem item) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Icon(
            item.icon,
            size: 20,
            color: Theme.of(context).textTheme.bodySmall?.color,
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                item.label,
                style: Theme.of(context).textTheme.bodySmall,
              ),
              const SizedBox(height: 2),
              if (item.isLink)
                GestureDetector(
                  onTap: () => _launchUrl(item.value),
                  child: Text(
                    item.value,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context).primaryColor,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                )
              else
                Text(
                  item.value,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
            ],
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.year}년 ${date.month}월 ${date.day}일';
  }

  Future<void> _launchUrl(String url) async {
    // Implement URL launching logic
  }
}

class InfoItem {
  final IconData icon;
  final String label;
  final String value;
  final bool isLink;

  InfoItem({
    required this.icon,
    required this.label,
    required this.value,
    this.isLink = false,
  });
}