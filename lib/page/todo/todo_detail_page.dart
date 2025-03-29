import 'package:flutter/material.dart';
import 'package:like_todo/base/custom_color.dart';
import 'package:like_todo/component/todo/todo_tag_item_view.dart';
import 'package:like_todo/entity/todo_entity.dart';
import 'package:like_todo/entity/todo_tag_entity.dart';
import 'package:tdesign_flutter/tdesign_flutter.dart';

import '../../component/todo/todo_detail_item.dart';

class TodoDetailPage extends StatelessWidget {
  const TodoDetailPage({
    super.key,
    required this.todoEntity,
    this.editCallback,
    this.deleteCallback,
  });

  final TodoEntity todoEntity;

  final Function(TodoEntity)? editCallback;
  final Function(String todoId)? deleteCallback;

  @override
  Widget build(BuildContext context) {
    final categoryTags = todoEntity.tags.where((tag) {
      return tag.type == TodoTagEntityType.category;
    }).toList();
    final complexityTags = todoEntity.tags.where((tag) {
      return tag.type == TodoTagEntityType.complexity;
    }).toList();
    final urgencyTags = todoEntity.tags.where((tag) {
      return tag.type == TodoTagEntityType.urgency;
    }).toList();
    final importanceTags = todoEntity.tags.where((tag) {
      return tag.type == TodoTagEntityType.importance;
    }).toList();
    final completionTags = todoEntity.tags.where((tag) {
      return tag.type == TodoTagEntityType.completion;
    }).toList();

    return Container(
      width: MediaQuery.of(context).size.width - 80,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      decoration: BoxDecoration(
          color: CustomColor.backgroundColor,
          borderRadius: BorderRadius.circular(20)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            todoEntity.title,
            style: const TextStyle(
              color: CustomColor.mainColor,
              decoration: TextDecoration.none,
              fontSize: 20,
              fontWeight: FontWeight.w400,
            ),
          ),
          TodoDetailItem(
            title: '备注：',
            body: Text(
              todoEntity.mark.isEmpty ? '无' : todoEntity.mark,
              style: _baseTextStyle(),
            ),
          ),
          TDDivider(
            color: CustomColor.mainColor.withOpacity(0.4),
            height: 0.5,
            margin: const EdgeInsets.symmetric(vertical: 5),
          ),
          Visibility(
            visible: todoEntity.startTime != null,
            child: TodoDetailItem(
              title: '开始时间：',
              body: Text(
                '${'${todoEntity.startTime?.hour ?? 0}'.padLeft(2, '0')}:${'${todoEntity.startTime?.minute ?? 0}'.padLeft(2, '0')}',
                style: _baseTextStyle(),
              ),
            ),
          ),
          Visibility(
            visible: todoEntity.endTime != null,
            child: TodoDetailItem(
              title: '结束时间：',
              body: Text(
                '${'${todoEntity.endTime?.hour ?? 0}'.padLeft(2, '0')}:${'${todoEntity.endTime?.minute ?? 0}'.padLeft(2, '0')}',
                style: _baseTextStyle(),
              ),
            ),
          ),
          Visibility(
            visible: categoryTags.isNotEmpty,
            child: TodoDetailItem(
              title: '类别：',
              body: categoryTags.isEmpty
                  ? Text('无', style: _baseTextStyle())
                  : TodoTagItemView(
                      entity: categoryTags[0],
                      isSelected: false,
                      canClose: false,
                    ),
            ),
          ),
          Visibility(
            visible: categoryTags.isNotEmpty,
            child: TodoDetailItem(
              title: '复杂程度：',
              body: complexityTags.isEmpty
                  ? Text('无', style: _baseTextStyle())
                  : TodoTagItemView(
                      entity: complexityTags[0],
                      isSelected: false,
                      canClose: false,
                    ),
            ),
          ),
          Visibility(
            visible: categoryTags.isNotEmpty,
            child: TodoDetailItem(
              title: '紧急程度：',
              body: urgencyTags.isEmpty
                  ? Text('无', style: _baseTextStyle())
                  : TodoTagItemView(
                      entity: urgencyTags[0],
                      isSelected: false,
                      canClose: false,
                    ),
            ),
          ),
          Visibility(
            visible: categoryTags.isNotEmpty,
            child: TodoDetailItem(
              title: '重要程度：',
              body: importanceTags.isEmpty
                  ? Text('无', style: _baseTextStyle())
                  : TodoTagItemView(
                      entity: importanceTags[0],
                      isSelected: false,
                      canClose: false,
                    ),
            ),
          ),
          Visibility(
            visible: categoryTags.isNotEmpty,
            child: TodoDetailItem(
              title: '达到效果：',
              body: completionTags.isEmpty
                  ? Text('无', style: _baseTextStyle())
                  : TodoTagItemView(
                      entity: completionTags[0],
                      isSelected: false,
                      canClose: false,
                    ),
            ),
          ),
          Visibility(
            visible: categoryTags.isNotEmpty,
            child: TodoDetailItem(
              title: '达到效果：',
              body: completionTags.isEmpty
                  ? Text('无', style: _baseTextStyle())
                  : TodoTagItemView(
                      entity: completionTags[0],
                      isSelected: false,
                      canClose: false,
                    ),
            ),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                  child: TDButton(
                size: TDButtonSize.medium,
                textStyle: const TextStyle(
                  color: CustomColor.mainColor,
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                ),
                style: TDButtonStyle(
                    backgroundColor: Colors.white,
                    radius: BorderRadius.circular(8)),
                onTap: () {
                  Navigator.pop(context);
                  editCallback?.call(todoEntity);
                },
                text: '编辑',
              )),
              const SizedBox(width: 20),
              Expanded(
                  child: TDButton(
                size: TDButtonSize.medium,
                textStyle: const TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                ),
                style: TDButtonStyle(
                    backgroundColor: Colors.redAccent,
                    radius: BorderRadius.circular(8)),
                onTap: () {
                  Navigator.pop(context);
                  deleteCallback?.call(todoEntity.id);
                },
                text: '删除',
              )),
            ],
          )
        ],
      ),
    );
  }

  TextStyle _baseTextStyle() {
    return const TextStyle(
      color: CustomColor.mainColor,
      decoration: TextDecoration.none,
      fontSize: 15,
      fontWeight: FontWeight.w400,
    );
  }
}
