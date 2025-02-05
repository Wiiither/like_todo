import 'package:flutter/cupertino.dart';
import 'package:like_todo/component/todo/todo_tag_category_group_view.dart';
import 'package:like_todo/component/todo/todo_tag_select_header.dart';
import 'package:like_todo/entity/todo_tag_entity.dart';

class TodoTagSelectPage extends StatefulWidget {
  const TodoTagSelectPage({
    super.key,
    required this.selectedTags,
    this.onSelectedTags,
  });

  final List<TodoTagEntity> selectedTags;
  final Function(List<TodoTagEntity>)? onSelectedTags;

  @override
  State<TodoTagSelectPage> createState() => _TodoTagSelectPageState();
}

class _TodoTagSelectPageState extends State<TodoTagSelectPage> {
  late List<TodoTagEntity> _selectedTags;

  @override
  void initState() {
    super.initState();
    _selectedTags = List.from(widget.selectedTags);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TodoTagSelectHeader(
              title: '选择标签',
              confirmCallback: () {
                widget.onSelectedTags?.call(_selectedTags);
                Navigator.of(context).pop();
              }),
          SizedBox(
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 0.4,
            child: ListView.builder(
                itemCount: TodoTagEntityType.values.length + 1,
                itemBuilder: (context, index) {
                  if (index == 0) {
                    return TodoTagCategoryGroupView(
                      title: '已选',
                      tags: _selectedTags,
                      selectedTags: _selectedTags,
                      onSelectedTag: _updateTags,
                    );
                  } else {
                    TodoTagEntityType type =
                        TodoTagEntityType.values[index - 1];
                    return TodoTagCategoryGroupView(
                      title: type.name(),
                      tags: defaultTodoTags
                          .where((entity) => entity.type == type)
                          .toList(),
                      selectedTags: _selectedTags,
                      onSelectedTag: _updateTags,
                    );
                  }
                }),
          )
        ],
      ),
    );
  }

  void _updateTags(TodoTagEntity tag) {
    setState(() {
      if (_selectedTags.contains(tag)) {
        _selectedTags.remove(tag);
      } else {
        _selectedTags.add(tag);
      }
    });
    print('更新Tag $tag');
    print('_selectedTags $_selectedTags');
  }
}
