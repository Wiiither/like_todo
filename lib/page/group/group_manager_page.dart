import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:like_todo/base/base_component.dart';
import 'package:like_todo/base/custom_color.dart';
import 'package:like_todo/bloc/todo/todo_bloc.dart';
import 'package:like_todo/component/group/add_new_group_view.dart';
import 'package:like_todo/component/group/group_manager_item_view.dart';
import 'package:styled_widget/styled_widget.dart';
import 'package:tdesign_flutter/tdesign_flutter.dart';

class GroupManagerPage extends StatelessWidget {
  const GroupManagerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildBaseNavBar(context: context, title: '分组管理'),
      body: BlocBuilder<TodoBloc, TodoState>(builder: (context, state) {
        return ListView.builder(
          itemCount: state.todoGroupList.length,
          itemBuilder: (context, index) {
            return GroupManagerItemView(
              todoGroupEntity: state.todoGroupList[index],
            );
          },
        );
      }).padding(top: 10),
      bottomNavigationBar: GestureDetector(
        onTap: () {
          _showAddGroupView(context);
        },
        child: Container(
          alignment: Alignment.topCenter,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(20)),
          padding: const EdgeInsets.only(top: 15),
          height: 72,
          child: const Text(
            '新增分组',
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.bold,
              color: CustomColor.mainColor,
            ),
          ),
        ),
      ),
    );
  }

  void _showAddGroupView(BuildContext context) {
    Navigator.of(context).push(
      TDSlidePopupRoute(
        modalBarrierColor: TDTheme.of(context).fontGyColor2,
        slideTransitionFrom: SlideTransitionFrom.center,
        builder: (buildContext) => BlocProvider.value(
          value: context.read<TodoBloc>(),
          child: AddNewGroupView(),
        ),
      ),
    );
  }
}
