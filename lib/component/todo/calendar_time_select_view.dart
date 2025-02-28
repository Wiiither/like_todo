import 'package:flutter/material.dart';
import 'package:styled_widget/styled_widget.dart';
import 'package:tdesign_flutter/tdesign_flutter.dart';

class CalendarTimeSelectView extends StatefulWidget {
  const CalendarTimeSelectView({
    super.key,
    required this.title,
    this.defaultDateTime,
    this.onSelectedDateTime,
  });

  final DateTime? defaultDateTime;
  final String title;
  final Function(DateTime)? onSelectedDateTime;

  @override
  State<CalendarTimeSelectView> createState() => _CalendarTimeSelectViewState();
}

class _CalendarTimeSelectViewState extends State<CalendarTimeSelectView> {
  late DateTime _selectedDateTime;

  //  是否正在选择时间
  bool _isShowTime = false;
  bool _isSelectDate = false;

  @override
  void initState() {
    super.initState();
    _selectedDateTime = widget.defaultDateTime ?? DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 600,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TDButton(
                text: _isShowTime ? '返回' : '取消',
                type: TDButtonType.text,
                onTap: () {
                  if (_isShowTime) {
                    setState(() {
                      _isShowTime = false;
                    });
                  } else {
                    Navigator.of(context).pop();
                  }
                },
              ),
              TDButton(
                text: _isShowTime ? '确定' : '继续',
                type: TDButtonType.text,
                onTap: () {
                  if (_isShowTime) {
                    print('当前选择的时间 ${_selectedDateTime}');
                    widget.onSelectedDateTime?.call(_selectedDateTime);
                    Navigator.of(context).pop();
                  } else {
                    if (!_isSelectDate) {
                      TDToast.showText('你需要选择一个日期', context: context);
                      return;
                    }
                    setState(() {
                      _isShowTime = true;
                    });
                  }
                },
              ),
            ],
          ).padding(bottom: 20),
          Expanded(
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 200),
              transitionBuilder: (child, animation) {
                return SlideTransition(
                  position: Tween<Offset>(
                    begin: const Offset(1.0, 0.0), // 从左往右
                    end: const Offset(0.0, 0.0),
                  ).animate(animation),
                  child: FadeTransition(
                    opacity: animation,
                    child: child,
                  ),
                );
              },
              child: _isShowTime ? _buildTimeSelector() : _buildCalendar(),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildCalendar() {
    return TDCalendar(
      title: '',
      value: null,
      cellHeight: 50,
      style: TDCalendarStyle(),
      onChange: (value) {
        DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(value[0]);
        _selectedDateTime = DateTime(
          dateTime.year,
          dateTime.month,
          dateTime.day,
          _selectedDateTime.hour,
          _selectedDateTime.minute,
        );
        //  标记已选择日期，可以继续选择时间
        _isSelectDate = true;
      },
    );
  }

  Widget _buildTimeSelector() {
    return TDDatePicker(
      title: '',
      leftText: '',
      rightText: '',
      backgroundColor: Colors.transparent,
      onConfirm: null,
      model: DatePickerModel(
          useYear: false,
          useMonth: false,
          useDay: false,
          useHour: true,
          useMinute: true,
          useWeekDay: false,
          useSecond: false,
          dateStart: [
            2025,
            1,
            1,
            0,
            0
          ],
          dateEnd: [
            2025,
            1,
            1,
            23,
            59
          ],
          dateInitial: [
            2025,
            1,
            1,
            _selectedDateTime.hour,
            _selectedDateTime.minute,
          ]),
      isTimeUnit: true,
      pickerItemCount: 5,
      pickerHeight: 300,
      onSelectedItemChanged: (wheelIndex, index) {
        if (wheelIndex == 4) {
          _selectedDateTime = DateTime(
            _selectedDateTime.year,
            _selectedDateTime.month,
            _selectedDateTime.day,
            index,
            _selectedDateTime.minute,
          );
        } else if (wheelIndex == 5) {
          _selectedDateTime = DateTime(
            _selectedDateTime.year,
            _selectedDateTime.month,
            _selectedDateTime.day,
            _selectedDateTime.hour,
            index,
          );
        }
      },
    );
  }
}
