import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:like_todo/base/custom_color.dart';
import 'package:like_todo/page/todo/todo_group_list_page.dart';
import 'package:like_todo/page/todo/todo_tag_list_page.dart';
import 'package:tdesign_flutter/tdesign_flutter.dart';

import '../../bloc/todo/todo_bloc.dart';
import '../../component/todo/todo_header.dart';
import '../../entity/todo_entity.dart';
import 'create_todo_page.dart';

class TodoPage extends StatefulWidget {
  const TodoPage({super.key});

  @override
  State<TodoPage> createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TodoHeader(
        tabController: _tabController,
      ),
      backgroundColor: Colors.white,
      body: TabBarView(
          controller: _tabController,
          children: const [TodoGroupListPage(), TodoTagListPage()]),
      floatingActionButton: TDButton(
        width: 48,
        height: 48,
        shape: TDButtonShape.circle,
        style: TDButtonStyle(backgroundColor: CustomColor.backgroundColor),
        onTap: () {
          _handleAddTodo(context);
        },
        child: const Icon(TDIcons.add, color: CustomColor.mainColor),
      ),
    );
  }

  void _handleAddTodo(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (buildContext) => BlocProvider.value(
          value: context.read<TodoBloc>(),
          child: CreateTodoPage(
            todoEntity: TodoEntity(id: newToDoID),
          ),
        ),
      ),
    );
  }
}
