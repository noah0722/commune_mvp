import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:commune/core/constants/app_strings.dart';
import 'package:commune/features/post/widgets/post_write_form.dart';

class PostWriteView extends ConsumerWidget {
  const PostWriteView({
    super.key,
    required this.muId,
  });
  final String muId;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.postWrite),
      ),
      body: const PostWriteForm(),
    );
  }
}
