import 'package:commune/core/models/post.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:commune/features/post/providers/post_write_provider.dart';
import 'package:commune/features/post/widgets/media_upload_field.dart';
import 'package:commune/features/post/widgets/link_input_field.dart';
import 'package:commune/features/post/widgets/poll_input_field.dart';
import 'package:commune/features/post/widgets/rich_text_editor.dart';

class PostContentField extends ConsumerWidget {
  final TextEditingController controller;

  const PostContentField({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final postType = ref.watch(postTypeProvider);

    switch (postType) {
      case PostType.text:
        return RichTextEditor(controller: controller);
      case PostType.media:
        return MediaUploadField(controller: controller);
      case PostType.link:
        return LinkInputField(controller: controller);
      case PostType.poll:
        return PollInputField(controller: controller);
    }
  }
}