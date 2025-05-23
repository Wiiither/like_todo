import 'package:flutter/material.dart';
import 'package:like_todo/base/custom_color.dart';
import 'package:tdesign_flutter/tdesign_flutter.dart';

class CreateTodoContentView extends StatefulWidget {
  const CreateTodoContentView({
    super.key,
    this.defaultTitle,
    this.defaultContent,
    this.titleEditComplete,
    this.contentEditComplete,
  });

  final String? defaultTitle;
  final String? defaultContent;
  final Function(String)? titleEditComplete;
  final Function(String)? contentEditComplete;

  @override
  State<CreateTodoContentView> createState() => _CreateTodoContentViewState();
}

class _CreateTodoContentViewState extends State<CreateTodoContentView> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();
  final FocusNode _titleFocusNode = FocusNode();
  final FocusNode _contentFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _titleController.text = widget.defaultTitle ?? '';
    _contentController.text = widget.defaultContent ?? '';
    _titleFocusNode.addListener(() {
      if (!_titleFocusNode.hasFocus) {
        widget.titleEditComplete?.call(_titleController.text);
      }
    });
    _contentFocusNode.addListener(() {
      if (!_contentFocusNode.hasFocus) {
        widget.contentEditComplete?.call(_contentController.text);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: CustomColor.quaternaryColor, width: 1.5),
      ),
      child: Column(
        children: [
          _buildTitleInput(),
          const TDDivider(
            margin: EdgeInsets.symmetric(horizontal: 20),
            color: CustomColor.quaternaryColor,
            height: 0.5,
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
        color: CustomColor.mainColor,
      ),
      cursorColor: CustomColor.mainColor,
      showBottomDivider: false,
      needClear: false,
      onTapOutside: (_) {
        _titleFocusNode.unfocus();
      },
      focusNode: _titleFocusNode,
      controller: _titleController,
    );
  }

  //  输入备注部分
  Widget _buildMarkInput() {
    return TDInput(
      maxLines: 5,
      hintText: "备注",
      showBottomDivider: false,
      textStyle: const TextStyle(
        fontSize: 17,
        fontWeight: FontWeight.w400,
        color: CustomColor.mainColor,
      ),
      cursorColor: CustomColor.mainColor,
      needClear: false,
      onTapOutside: (_) {
        _contentFocusNode.unfocus();
      },
      inputAction: TextInputAction.done,
      focusNode: _contentFocusNode,
      controller: _contentController,
    );
  }
}
