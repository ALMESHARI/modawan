import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:modawan/core/components/widgets/custom_containers.dart';
import 'package:modawan/core/router/router.dart';

class BlogEditorPage extends StatelessWidget {
  BlogEditorPage({super.key});
  final QuillController _controller = QuillController.basic();

  Future<void> _addEditNote(BuildContext context, {Document? document}) async {
    _controller.readOnly = true;
    final isEditing = document != null;
    final quillEditorController = QuillController(
      document: document ?? Document(),
      selection: const TextSelection.collapsed(offset: 0),
    );

    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        titlePadding: const EdgeInsets.only(left: 16, top: 8),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('${isEditing ? 'Edit' : 'Add'} note'),
            IconButton(
              onPressed: () => Navigator.of(context).pop(),
              icon: const Icon(Icons.close),
            )
          ],
        ),
        content: QuillEditor.basic(
          configurations: QuillEditorConfigurations(
            controller: quillEditorController,
          ),
        ),
      ),
    );

    if (quillEditorController.document.isEmpty()) return;

    final block = BlockEmbed.custom(
      NotesBlockEmbed.fromDocument(quillEditorController.document),
    );
    final controller = _controller!;
    final index = controller.selection.baseOffset;
    final length = controller.selection.extentOffset - index;

    if (isEditing) {
      final offset =
          getEmbedNode(controller, controller.selection.start).offset;
      controller.replaceText(
          offset, 1, block, TextSelection.collapsed(offset: offset));
    } else {
      controller.replaceText(index, length, block, null);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: AppBar(
        title: const Text('Blog Editor'),
        actions: [
          //back button
         
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(bottom: 50),
        child: QuillEditor.basic(
          configurations: QuillEditorConfigurations(
            expands: true,
            embedBuilders: [
              NotesEmbedBuilder(addEditNote: _addEditNote),
            ],
            controller: _controller,
            sharedConfigurations: const QuillSharedConfigurations(
              locale: Locale('ar'),
            ),
          ),
        ),
      ),
      bottomSheet: GlassContainer(
        radius: 0,
        child: QuillToolbar.simple(
          configurations: QuillSimpleToolbarConfigurations(
            color: Colors.transparent,
            multiRowsDisplay: false,
            toolbarSectionSpacing: 0,
            // show only italic, bold, underline, code block, list and link
            showAlignmentButtons: false,
            showBackgroundColorButton: false,
             showDividers : false,
   showFontFamily : false,
   showFontSize : false,
   showStrikeThrough : false,
   showInlineCode : false,
   showColorButton :false,
   showClearFormat : false,
   showClipboardCopy: false,
    showIndent: false,
    showListNumbers: false,
    showClipboardPaste: false,
    showSearchButton: false,
    showSubscript: false,
    showSuperscript: false,
    showListCheck: false,
    showQuote: false,
    showClipboardCut: false,
    showHeaderStyle: false,
    
            embedButtons: [
              (QuillController controller, double size, _, __) => IconButton(
                    icon: const Icon(Icons.notes),
                    onPressed: () => _addEditNote(context),
                  ),
            ],
            controller: _controller,
            sharedConfigurations: const QuillSharedConfigurations(
              locale: Locale('ar'),
            ),
          ),
        ),
      ),
    );
  }
}

class NotesBlockEmbed extends CustomBlockEmbed {
  const NotesBlockEmbed(String value) : super(noteType, value);

  static const String noteType = 'notes';

  static NotesBlockEmbed fromDocument(Document document) =>
      NotesBlockEmbed(jsonEncode(document.toDelta().toJson()));

  Document get document => Document.fromJson(jsonDecode(data));
}

class NotesEmbedBuilder extends EmbedBuilder {
  NotesEmbedBuilder({required this.addEditNote});

  Future<void> Function(BuildContext context, {Document? document}) addEditNote;

  @override
  String get key => 'notes';

  @override
  Widget build(
    BuildContext context,
    QuillController controller,
    Embed node,
    bool readOnly,
    bool inline,
    TextStyle textStyle,
  ) {
    final notes = NotesBlockEmbed(node.value.data).document;

    return Material(
      color: Colors.transparent,
      child: ListTile(
        title: Text(
          notes.toPlainText().replaceAll('\n', ' '),
          maxLines: 3,
          overflow: TextOverflow.ellipsis,
        ),
        leading: const Icon(Icons.notes),
        onTap: () => addEditNote(context, document: notes),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: const BorderSide(color: Colors.grey),
        ),
      ),
    );
  }
}
