import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:commune/features/post/providers/poll_provider.dart';

class PollInputField extends ConsumerWidget {
  const PollInputField({
    super.key,
    required this.controller,
  });
  final TextEditingController controller;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final options = ref.watch(pollOptionsProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ReorderableListView(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          children: [
            for (var i = 0; i < options.length; i++)
              _buildOptionField(
                context,
                ref,
                options[i],
                i,
              ),
          ],
          onReorder: (oldIndex, newIndex) {
            ref.read(pollOptionsProvider.notifier).reorderOptions(
                  oldIndex,
                  newIndex,
                );
          },
        ),
        const SizedBox(height: 16),
        if (options.length < 10)
          OutlinedButton.icon(
            onPressed: () {
              ref.read(pollOptionsProvider.notifier).addOption();
            },
            icon: const Icon(Icons.add),
            label: const Text('옵션 추가'),
          ),
        const SizedBox(height: 16),
        TextFormField(
          controller: controller,
          decoration: const InputDecoration(
            hintText: '투표 설명을 입력하세요 (선택사항)',
          ),
          maxLines: 3,
        ),
      ],
    );
  }

  Widget _buildOptionField(
    BuildContext context,
    WidgetRef ref,
    PollOption option,
    int index,
  ) {
    final optionsList = ref.watch(pollOptionsProvider); // Add this line

    return Container(
      key: ValueKey(option.id),
      margin: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Icon(
            Icons.drag_handle,
            color: Theme.of(context).hintColor,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: TextFormField(
              controller: option.controller,
              decoration: InputDecoration(
                hintText: '옵션 ${index + 1}',
                suffixIcon:
                    optionsList.length > 2 // Use optionsList instead of options
                        ? IconButton(
                            icon: const Icon(Icons.close),
                            onPressed: () {
                              ref
                                  .read(pollOptionsProvider.notifier)
                                  .removeOption(index);
                            },
                          )
                        : null,
              ),
              validator: (value) {
                if (value?.trim().isEmpty ?? true) {
                  return '옵션을 입력해주세요';
                }
                return null;
              },
            ),
          ),
        ],
      ),
    );
  }
}
