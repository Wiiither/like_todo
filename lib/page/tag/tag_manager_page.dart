import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:like_todo/base/base_component.dart';
import 'package:like_todo/bloc/tag/tag_bloc.dart';
import 'package:like_todo/component/tag/tag_manager_item_view.dart';
import 'package:like_todo/entity/todo_tag_entity.dart';

class TagManagerPage extends StatefulWidget {
  const TagManagerPage({super.key});

  @override
  State<TagManagerPage> createState() => _TagManagerPageState();
}

class _TagManagerPageState extends State<TagManagerPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildBaseNavBar(context: context, title: '标签管理'),
      backgroundColor: Colors.white,
      body: BlocBuilder<TagBloc, TagState>(
        builder: (context, state) {
          List<TodoTagEntityType> tagTypes = TodoTagEntityType.values;
          return ListView.builder(
              itemCount: tagTypes.length,
              itemBuilder: (context, index) {
                final type = tagTypes[index];
                List<TodoTagEntity> todoTagEntityList = state.todoTagList
                    .where((item) => item.type == type)
                    .toList();
                return TagManagerItemView(
                  type: type,
                  todoTagList: todoTagEntityList,
                );
              });
        },
      ),
    );
  }
}
