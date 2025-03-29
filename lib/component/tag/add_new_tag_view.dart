import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:like_todo/base/custom_color.dart';
import 'package:like_todo/bloc/tag/tag_bloc.dart';
import 'package:like_todo/entity/todo_tag_entity.dart';
import 'package:tdesign_flutter/tdesign_flutter.dart';

class AddNewTagView extends StatelessWidget {
  AddNewTagView({super.key, required this.type});

  final TodoTagEntityType type;
  final TextEditingController _textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        width: MediaQuery.of(context).size.width - 80,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              '新增标签',
              style: TextStyle(
                color: CustomColor.mainColor,
                decoration: TextDecoration.none,
                fontSize: 17,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 10),
            TDInput(
              controller: _textEditingController,
              cursorColor: CustomColor.mainColor,
              inputDecoration: const InputDecoration(
                hintText: '请输入标签名称',
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: double.infinity,
              child: TDButton(
                onTap: () {
                  final tagName = _textEditingController.text;
                  if (_handleCreateTag(context: context, tagName: tagName)) {
                    Navigator.pop(context);
                  }
                },
                size: TDButtonSize.small,
                style: TDButtonStyle(
                  backgroundColor: CustomColor.mainColor,
                  textColor: Colors.white,
                ),
                text: '保存',
              ),
            )
          ],
        ),
      ),
    );
  }

  bool _handleCreateTag(
      {required BuildContext context, required String tagName}) {
    if (tagName.isEmpty) {
      TDToast.showText('标签名称不能为空', context: context);
      return false;
    }
    final bloc = context.read<TagBloc>();
    final tagList = bloc.state.todoTagList;
    TodoTagEntity todoTagEntity = TodoTagEntity(name: tagName, type: type);
    final containSameTag = tagList.any((item) => item == todoTagEntity);
    if (containSameTag) {
      TDToast.showText('该类型存在相同名称的Tag，请重命名', context: context);
      return false;
    }

    bloc.add(AddNewTagEvent(todoTag: todoTagEntity));
    return true;
  }
}
