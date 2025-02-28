import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:like_todo/base/base_component.dart';
import 'package:like_todo/bloc/todo/todo_bloc.dart';
import 'package:like_todo/component/todo/create_todo_select_view.dart';
import 'package:like_todo/entity/todo_entity.dart';
import 'package:like_todo/entity/todo_group_entity.dart';
import 'package:like_todo/page/todo/todo_tag_select_page.dart';
import 'package:tdesign_flutter/tdesign_flutter.dart';

import '../../base/custom_color.dart';
import '../../component/todo/create_todo_content_view.dart';
import '../../component/todo/create_todo_tag_view.dart';
import '../../component/todo/create_todo_time_view.dart';

class CreateTodoPage extends StatefulWidget {
  const CreateTodoPage({
    super.key,
    this.isEdit = false,
    required this.todoEntity,
  });

  //  是否编辑 Todo
  final bool isEdit;
  final TodoEntity todoEntity;

  @override
  State<CreateTodoPage> createState() => _CreateTodoPageState();
}

class _CreateTodoPageState extends State<CreateTodoPage> {
  late TodoGroupEntity _selectedGroup;

  @override
  void initState() {
    super.initState();
    final bloc = context.read<TodoBloc>();
    _selectedGroup =
        bloc.state.todoGroupList.firstWhere((item) => item.isDefault);
  }

  @override
  Widget build(BuildContext context) {
    DateTime? startTime = widget.todoEntity.startTime;
    DateTime? endTime = widget.todoEntity.endTime;
    final bloc = context.read<TodoBloc>();
    List<TodoGroupEntity> groupList = bloc.state.todoGroupList;

    return Scaffold(
      appBar: buildBaseNavBar(
        context: context,
        title: widget.isEdit ? '修改 ToDo ' : '创建 ToDo',
      ),
      body: SafeArea(
        child: GestureDetector(
          onTap: () {
            _unFocusAll(context);
          },
          child: Column(
            children: [
              CreateTodoContentView(
                defaultTitle: widget.todoEntity.title,
                defaultContent: widget.todoEntity.mark,
                titleEditComplete: (title) {
                  print("修改 ToDo 标题 $title");
                  widget.todoEntity.title = title;
                },
                contentEditComplete: (content) {
                  print("修改 ToDo 备注 $content");
                  widget.todoEntity.mark = content;
                },
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5),
                  boxShadow: const [
                    BoxShadow(
                      color: CustomColor.shadowColor,
                      blurRadius: 5,
                      spreadRadius: 0,
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    CreateTodoTimeView(
                      title: '开始时间',
                      content: startTime != null
                          ? _dateTimeToString(startTime)
                          : '请选择',
                      clearState: startTime != null,
                      onSelectedDateTime: (dateTime) {
                        print("新的开始时间 ${dateTime}");
                        setState(() {
                          widget.todoEntity.startTime = dateTime;
                          print("hello ${widget.todoEntity.startTime}");
                        });
                      },
                      onClearDateTime: () {
                        setState(() {
                          widget.todoEntity.startTime = null;
                        });
                      },
                    ),
                    CreateTodoTimeView(
                      title: '结束时间',
                      content:
                          endTime != null ? _dateTimeToString(endTime) : '请选择',
                      clearState: endTime != null,
                      onSelectedDateTime: (dateTime) {
                        print("新的结束时间 ${dateTime}");
                        setState(() {
                          widget.todoEntity.endTime = dateTime;
                        });
                      },
                      onClearDateTime: () {
                        setState(() {
                          widget.todoEntity.startTime = null;
                        });
                      },
                    ),
                    CreateTodoSelectView(
                      title: '分组',
                      defaultValue: _selectedGroup,
                      dataSource: groupList,
                      onSelectedCallback: (group) {
                        setState(() {
                          _selectedGroup = group;
                        });
                      },
                    ),
                    CreateTodoTagView(
                      selectedTags: widget.todoEntity.tags,
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          builder: (context) {
                            return TodoTagSelectPage(
                              selectedTags: widget.todoEntity.tags,
                              onSelectedTags: (tags) {
                                setState(() {
                                  widget.todoEntity.tags = tags;
                                });
                              },
                            );
                          },
                        );
                      },
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: TDButton(
            width: double.infinity,
            height: 48,
            margin: const EdgeInsets.symmetric(horizontal: 20),
            style: TDButtonStyle(
                backgroundColor: CustomColor.mainColor,
                textColor: Colors.white,
                radius: BorderRadius.circular(20)),
            text: '保存',
            onTap: () {
              _unFocusAll(context);
              _handleSave(context);
            },
          ),
        ),
      ),
    );
  }

  String _dateTimeToString(DateTime dateTime) {
    return "${"${dateTime.year}".padLeft(4, '0')}/${"${dateTime.month}".padLeft(2, '0')}/${"${dateTime.day}".padLeft(2, '0')}  ${"${dateTime.hour}".padLeft(2, '0')}:${"${dateTime.minute}".padLeft(2, '0')}";
  }

  //  处理保存
  void _handleSave(BuildContext context) async {
    final todoEntity = widget.todoEntity;
    final startTime = todoEntity.startTime;
    final endTime = todoEntity.endTime;

    if (todoEntity.title.isEmpty) {
      TDToast.showText('ToDo 的标题不能为空', context: context);
      return;
    } else if (startTime != null &&
        endTime != null &&
        endTime.isBefore(startTime)) {
      //  开始时间在结束时间之后
      TDToast.showText('ToDo 的结束时间不能早于开始时间', context: context);
      return;
    }
    final bloc = BlocProvider.of<TodoBloc>(context);
    if (todoEntity.id == newToDoID) {
      todoEntity.id = _generateTodoId();
      bloc.add(AddNewTodoEvent(
        todoEntity: todoEntity,
        groupEntity: _selectedGroup,
      ));
      TDToast.showText('创建成功', context: context);
    } else {
      bloc.add(UpdateTodoEvent(todoEntity: todoEntity));
      TDToast.showText('修改成功', context: context);
    }
    Navigator.pop(context);
  }

  String _generateTodoId() {
    DateTime now = DateTime.now();
    int timestamp = now.millisecondsSinceEpoch;
    return "todo_$timestamp";
  }

  void _unFocusAll(BuildContext context) {
    print('_unFocusAll');
    FocusScope.of(context).unfocus();
  }
}
