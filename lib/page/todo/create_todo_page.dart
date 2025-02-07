import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:like_todo/bloc/todo/todo_bloc.dart';
import 'package:like_todo/entity/todo_entity.dart';
import 'package:like_todo/entity/todo_repeat_type.dart';
import 'package:like_todo/page/todo/todo_tag_select_page.dart';
import 'package:like_todo/utils/database_helper.dart';
import 'package:tdesign_flutter/tdesign_flutter.dart';

import '../../base/custom_color.dart';
import '../../component/todo/create_todo_content_view.dart';
import '../../component/todo/create_todo_select_view.dart';
import '../../component/todo/create_todo_tag_view.dart';
import '../../component/todo/create_todo_time_view.dart';

class CreateTodoPage extends StatefulWidget {
  const CreateTodoPage({
    super.key,
    this.isEdit = false,
    required this.todoEntity,
    required this.context,
  });

  final bool isEdit;
  final TodoEntity todoEntity;
  final BuildContext context;

  @override
  State<CreateTodoPage> createState() => _CreateTodoPageState();
}

class _CreateTodoPageState extends State<CreateTodoPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    DateTime? date = widget.todoEntity.date;
    DateTime? startTime = widget.todoEntity.startTime;
    DateTime? endTime = widget.todoEntity.endTime;

    return Scaffold(
      appBar: TDNavBar(
        title: widget.isEdit ? "修改 ToDo" : "创建 ToDo",
      ),
      body: SafeArea(
        child: Column(
          children: [
            CreateTodoContentView(
              titleEditComplete: (title) {
                print("修改 ToDo 标题 $title");
                widget.todoEntity.title = title;
              },
              contentEditComplete: (content) {
                print("修改 ToDo 备注 $content");
                widget.todoEntity.mark = content;
              },
            ),
            CreateTodoTimeView(
              title: '日期',
              content: date != null
                  ? _dateTimeToString(date, SelectedTimeType.day)
                  : '请选择',
              timeType: SelectedTimeType.day,
              onSelectedDateTime: (dateTime) {
                print("日期 ${dateTime}");
                setState(() {
                  widget.todoEntity.date = dateTime;
                });
              },
            ),
            CreateTodoTimeView(
              title: '开始时间',
              content: startTime != null
                  ? _dateTimeToString(startTime, SelectedTimeType.hour)
                  : '请选择',
              timeType: SelectedTimeType.hour,
              onSelectedDateTime: (dateTime) {
                print("新的开始时间 ${dateTime}");
                setState(() {
                  widget.todoEntity.startTime = dateTime;
                });
              },
            ),
            CreateTodoTimeView(
              title: '结束时间',
              content: endTime != null
                  ? _dateTimeToString(endTime, SelectedTimeType.hour)
                  : '请选择',
              timeType: SelectedTimeType.hour,
              onSelectedDateTime: (dateTime) {
                print("新的结束时间 ${dateTime}");
                setState(() {
                  widget.todoEntity.endTime = dateTime;
                });
              },
            ),
            CreateTodoSelectView<TodoRepeatType>(
              title: '重复周期',
              dataSource: TodoRepeatType.defaultRepeatType,
              defaultValue: widget.todoEntity.repeatType,
              onSelectedCallback: (repeatType) {
                setState(() {
                  print("更新 repeat Type $repeatType");
                  widget.todoEntity.repeatType = repeatType;
                });
              },
            ),
            CreateTodoTagView(
              selectedTags: widget.todoEntity.tags,
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  // isScrollControlled: true,
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
      ),
      bottomNavigationBar: SafeArea(
          child: TDButton(
        width: double.infinity,
        margin: const EdgeInsets.symmetric(horizontal: 20),
        style: TDButtonStyle(
            backgroundColor: CustomColor.mainColor,
            textColor: Colors.white,
            radius: BorderRadius.circular(20)),
        text: '保存',
        onTap: () {
          _handleSave(widget.context);
        },
      )),
    );
  }

  String _dateTimeToString(DateTime dateTime, SelectedTimeType timeType) {
    if (timeType == SelectedTimeType.day) {
      return "${"${dateTime.year}".padLeft(4, '0')}/${"${dateTime.month}".padLeft(2, '0')}/${"${dateTime.day}".padLeft(2, '0')}";
    } else {
      return "${"${dateTime.hour}".padLeft(2, '0')}:${"${dateTime.minute}".padLeft(2, '0')}";
    }
  }

  //  处理保存
  void _handleSave(BuildContext context) async {
    final todoEntity = widget.todoEntity;
    if (todoEntity.title.isEmpty) {
      TDToast.showText('ToDo 的标题不能为空', context: context);
      return;
    } else if (todoEntity.startTime == null) {
      TDToast.showText('ToDo 的开始时间不能为空', context: context);
      return;
    } else if (todoEntity.endTime == null) {
      TDToast.showText('ToDo 的结束时间不能为空', context: context);
      return;
    } else if (todoEntity.startTime!.isAfter(todoEntity.endTime!)) {
      //  开始时间在结束时间之后
      TDToast.showText('ToDo 的结束时间不能为空', context: context);
      return;
    }
    final bloc = BlocProvider.of<TodoBloc>(widget.context);
    todoEntity.id = _generateTodoId();
    bloc.add(AddNewToDoEvent(todoEntity: todoEntity));
    await DatabaseHelper().insertTodoEntity(todoEntity);
    TDToast.showText('创建成功', context: context);
    Navigator.pop(context);
  }

  String _generateTodoId() {
    DateTime now = DateTime.now();
    int timestamp = now.millisecondsSinceEpoch;
    return "todo_$timestamp";
  }
}
