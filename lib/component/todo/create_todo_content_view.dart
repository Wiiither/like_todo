import 'package:flutter/material.dart';
import 'package:tdesign_flutter/tdesign_flutter.dart';

typedef StringCallBack = Function(String);

class CreateTodoContentView extends StatelessWidget {
  CreateTodoContentView({
    super.key,
    this.defaultTitle,
    this.defaultContent,
    this.titleEditComplete,
    this.contentEditComplete,
  }) {
    titleController.text = defaultTitle ?? '';
    contentController.text = defaultContent ?? '';
  }

  final String? defaultTitle;
  final String? defaultContent;
  final TextEditingController titleController = TextEditingController();
  final TextEditingController contentController = TextEditingController();
  final StringCallBack? titleEditComplete;
  final StringCallBack? contentEditComplete;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: Column(
        children: [
          _buildTitleInput(),
          const TDDivider(
            isDashed: true,
            margin: EdgeInsets.symmetric(horizontal: 20),
          ),
          _buildMarkInput(),
        ],
      ),
    );
  }

  //  输入标题部分
  Widget _buildTitleInput() {
    return TDInput(
      hintText: "标题",
      textStyle: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w600,
      ),
      showBottomDivider: false,
      needClear: false,
      controller: titleController,
      onChanged: (content) {
        titleEditComplete?.call(content);
      },
    );
  }

  //  输入备注部分
  Widget _buildMarkInput() {
    return TDInput(
      maxLines: 6,
      hintText: "备注",
      showBottomDivider: false,
      needClear: false,
      controller: contentController,
      onChanged: (content) {
        contentEditComplete?.call(content);
      },
    );
  }
}
