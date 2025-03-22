import 'package:flutter/material.dart';
import 'package:styled_widget/styled_widget.dart';
import 'package:tdesign_flutter/tdesign_flutter.dart';

import '../../base/custom_color.dart';

abstract class CreateTodoSelectViewDataSource {
  String getDisplayName();
}

class CreateTodoSelectView<T extends CreateTodoSelectViewDataSource>
    extends StatelessWidget {
  const CreateTodoSelectView({
    super.key,
    required this.title,
    this.defaultValue,
    this.defaultText = "请选择",
    required this.dataSource,
    this.onSelectedCallback,
  });

  final String title;
  final T? defaultValue;
  final String defaultText;
  final List<T> dataSource;
  final Function(T)? onSelectedCallback;

  @override
  Widget build(BuildContext context) {
    int initIndex = 0;
    if (defaultValue != null) {
      for (T type in dataSource) {
        if (type == defaultValue) {
          break;
        }
        initIndex++;
      }
    }

    return GestureDetector(
      onTap: () {
        List<String> dataArray = dataSource.map((item) {
          return item.getDisplayName();
        }).toList();
        TDPicker.showMultiPicker(
          context,
          pickerHeight: 300,
          onConfirm: (selected) {
            onSelectedCallback?.call(dataSource[selected[0]]);
            Navigator.pop(context);
          },
          leftTextStyle: const TextStyle(
            color: Colors.grey,
            fontSize: 15,
            fontWeight: FontWeight.w600,
          ),
          rightTextStyle: const TextStyle(
            color: CustomColor.mainColor,
            fontSize: 15,
            fontWeight: FontWeight.w600,
          ),
          initialIndexes: [initIndex],
          data: [dataArray],
        );
      },
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        margin: const EdgeInsets.symmetric(horizontal: 15),
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Row(
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: CustomColor.mainColor,
              ),
            ),
            const Spacer(),
            Text(
              defaultValue?.getDisplayName() ?? defaultText,
              style: const TextStyle(fontSize: 15, color: Colors.grey),
            ),
            const Icon(
              TDIcons.chevron_right,
              color: Colors.grey,
              size: 22,
            ).padding(left: 15),
          ],
        ),
      ),
    );
  }
}
