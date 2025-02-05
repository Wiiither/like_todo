import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:like_todo/bloc/todo/todo_bloc.dart';
import 'package:like_todo/component/todo/todo_header.dart';
import 'package:tdesign_flutter/tdesign_flutter.dart';

import '../../component/todo/todo_item_view.dart';

class TodoPage extends StatelessWidget {
  const TodoPage({super.key, required this.context});

  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size(double.infinity, 120),
        child: SafeArea(
          child: TodoHeader(
            context: this.context,
          ),
        ),
      ),
      body: BlocBuilder<TodoBloc, TodoState>(builder: (context, state) {
        return state.todoList.isEmpty
            ? const TDEmpty(
                type: TDEmptyType.plain,
                emptyText: 'DooooooooIt',
              )
            : ListView.builder(
                itemCount: state.todoList.length,
                itemBuilder: (context, index) {
                  return TodoItemView(
                    context: this.context,
                    todoEntity: state.todoList[index],
                  );
                },
              );
      }),
    );
  }
}
