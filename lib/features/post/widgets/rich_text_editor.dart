import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' hide Text;
import 'package:commune/core/utils/validator_utils.dart';

class RichTextEditor extends StatefulWidget {
  const RichTextEditor({
    super.key,
    required this.controller,
  });
  final TextEditingController controller;

  @override
  State<RichTextEditor> createState() => _RichTextEditorState();
}

class _RichTextEditorState extends State<RichTextEditor> {
  late QuillController _quillController;

  @override
  void initState() {
    super.initState();
    _quillController = QuillController.basic();
    _quillController.addListener(_updateController);
  }

  @override
  void dispose() {
    _quillController.removeListener(_updateController);
    _quillController.dispose();
    super.dispose();
  }

  void _updateController() {
    final plainText = _quillController.document.toPlainText();
    widget.controller.text = plainText.trim();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            border: Border(
              bottom: BorderSide(
                color: Theme.of(context).dividerColor,
              ),
            ),
          ),
          child: QuillToolbar.simple(
            configurations: QuillSimpleToolbarConfigurations(
              controller: _quillController,
            ),
          ),
        ),
        Container(
          height: 300,
          decoration: BoxDecoration(
            border: Border.all(
              color: Theme.of(context).dividerColor,
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          child: QuillEditor(
            configurations: QuillEditorConfigurations(
              controller: _quillController,
              readOnly: false,
              placeholder: '내용을 입력해주세요',
              scrollable: true,
              autoFocus: false,
              expands: false,
              padding: EdgeInsets.zero,
            ),
            focusNode: FocusNode(),
            scrollController: ScrollController(),
          ),
        ),
      ],
    );
  }
}
