import 'package:commune/core/models/post.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:commune/features/post/providers/post_write_provider.dart';

class PostTypeSelector extends ConsumerWidget {
  const PostTypeSelector({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedType = ref.watch(postTypeProvider);

    return Container(
      height: 56,
      decoration: BoxDecoration(
        border: Border.all(
          color: Theme.of(context).dividerColor,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: PostType.values.map((type) {
          final isSelected = type == selectedType;
          return Expanded(
            child: InkWell(
              onTap: () {
                ref.read(postTypeProvider.notifier).state = type;
              },
              child: Container(
                decoration: BoxDecoration(
                  color: isSelected
                      ? Theme.of(context).primaryColor.withOpacity(0.1)
                      : null,
                  border: Border(
                    bottom: BorderSide(
                      color: isSelected
                          ? Theme.of(context).primaryColor
                          : Colors.transparent,
                      width: 2,
                    ),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      _getIconForType(type),
                      color: isSelected
                          ? Theme.of(context).primaryColor
                          : null,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      _getLabelForType(type),
                      style: TextStyle(
                        fontSize: 12,
                        color: isSelected
                            ? Theme.of(context).primaryColor
                            : null,
                        fontWeight: isSelected
                            ? FontWeight.bold
                            : null,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  IconData _getIconForType(PostType type) {
    switch (type) {
      case PostType.text:
        return Icons.text_fields;
      case PostType.media:
        return Icons.image;
      case PostType.link:
        return Icons.link;
      case PostType.poll:
        return Icons.poll;
    }
  }

  String _getLabelForType(PostType type) {
    switch (type) {
      case PostType.text:
        return '텍스트';
      case PostType.media:
        return '이미지/영상';
      case PostType.link:
        return '링크';
      case PostType.poll:
        return '투표';
    }
  }
}