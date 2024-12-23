// #File: lib/features/post/widgets/link_input_field.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:commune/features/post/providers/link_preview_provider.dart';
import 'package:commune/core/widgets/link_preview_card.dart';
import 'package:commune/core/utils/validator_utils.dart';

class LinkInputField extends ConsumerWidget {
  final TextEditingController controller;

  const LinkInputField({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final preview = ref.watch(linkPreviewProvider(controller.text));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          controller: controller,
          decoration: const InputDecoration(
            hintText: '링크를 입력하세요',
            prefixIcon: Icon(Icons.link),
          ),
          keyboardType: TextInputType.url,
          textInputAction: TextInputAction.done,
          validator: (value) => ValidatorUtils.validateUrl(value),
          onChanged: (value) {
            if (value.isNotEmpty) {
              ref.invalidate(linkPreviewProvider(value));
            }
          },
        ),
        const SizedBox(height: 16),
        preview.when(
          data: (data) => data != null
              ? LinkPreviewCard(preview: data)
              : const SizedBox(),
          loading: () => const Center(
            child: CircularProgressIndicator(),
          ),
          error: (error, stack) => Text(
            error.toString(),
            style: TextStyle(
              color: Theme.of(context).colorScheme.error,
            ),
          ),
        ),
      ],
    );
  }
}