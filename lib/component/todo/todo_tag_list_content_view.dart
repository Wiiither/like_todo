import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:like_todo/bloc/tag/tag_bloc.dart';
import 'package:like_todo/component/todo/todo_tag_list_content_item_view.dart';
import 'package:like_todo/entity/todo_tag_entity.dart';

class TodoTagListContentView extends StatelessWidget {
  const TodoTagListContentView({
    super.key,
    required this.type,
  });

  final TodoTagEntityType type;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TagBloc, TagState>(builder: (context, state) {
      final tagList =
          state.todoTagList.where((item) => item.type == type).toList();
      return ListView.builder(
          itemCount: tagList.length,
          itemBuilder: (context, index) {
            return TodoTagListContentItemView();
          });
    });
  }
}
