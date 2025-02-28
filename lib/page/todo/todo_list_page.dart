import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:like_todo/component/todo/todo_item_view.dart';
import 'package:like_todo/entity/todo_entity.dart';
import 'package:like_todo/entity/todo_group_entity.dart';

import '../../bloc/todo/todo_bloc.dart';

class TodoListPage extends StatelessWidget {
  const TodoListPage({
    super.key,
    required this.groupEntity,
  });

  final TodoGroupEntity groupEntity;

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<TodoBloc>();

    List<TodoEntity> todoList =
        bloc.state.groupTodoMap[groupEntity.groupID] ?? [];
    
    print('todoList ${bloc.state.groupTodoMap}');
    return ListView.builder(
        itemCount: todoList.length,
        itemBuilder: (context, index) {
          return TodoItemView(todoEntity: todoList[index]);
        });
  }
}
