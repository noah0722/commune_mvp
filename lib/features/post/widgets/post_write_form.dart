import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:commune/core/constants/app_strings.dart';
import 'package:commune/core/utils/validator_utils.dart';
import 'package:commune/features/post/providers/post_write_provider.dart';
import 'package:commune/features/post/widgets/mu_selector.dart';
import 'package:commune/features/post/widgets/post_type_selector.dart';
import 'package:commune/features/post/widgets/post_content_field.dart';

class PostWriteForm extends ConsumerStatefulWidget {
  const PostWriteForm({super.key});

  @override
  ConsumerState<PostWriteForm> createState() => _PostWriteFormState();
}

class _PostWriteFormState extends ConsumerState<PostWriteForm> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final postState = ref.watch(postWriteProvider);

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            const MuSelector(),
            const SizedBox(height: 16),
            TextFormField(
              controller: _titleController,
              decoration: InputDecoration(
                labelText: AppStrings.postTitle,
                hintText: '제목을 입력해주세요',
              ),
              validator: (value) => ValidatorUtils.validatePostTitle(value),
              textInputAction: TextInputAction.next,
            ),
            const SizedBox(height: 16),
            const PostTypeSelector(),
            const SizedBox(height: 16),
            PostContentField(controller: _contentController),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: postState.isSubmitting ? null : _submitPost,
              child: postState.isSubmitting
                  ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                      ),
                    )
                  : Text(AppStrings.submit),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _submitPost() async {
    if (!_formKey.currentState!.validate()) return;

    try {
      await ref.read(postWriteProvider.notifier).submitPost(
        title: _titleController.text,
        content: _contentController.text,
      );

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(AppStrings.postCreated),
            behavior: SnackBarBehavior.floating,
          ),
        );
        Navigator.pop(context);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e.toString()),
            backgroundColor: Theme.of(context).colorScheme.error,
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    }
  }
}