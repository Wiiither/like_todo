import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tdesign_flutter/tdesign_flutter.dart';

import '../../base/custom_share_preference_key.dart';
import '../../component/me/setting_switch_view.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  SettingPageState createState() => SettingPageState();
}

class SettingPageState extends State<SettingPage> {
  bool _showIncomplete = true;
  bool _showTodayOnly = false;

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _showIncomplete = prefs.getBool(showIncomplete) ?? true;
      _showTodayOnly = prefs.getBool(showTodayOnly) ?? false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TDNavBar(
        title: '设置',
      ),
      body: Column(
        children: [
          SettingSwitchView(
            title: '是否显示未完成',
            isOn: _showIncomplete,
            changeCallBack: (result) async {
              final prefs = await SharedPreferences.getInstance();
              prefs.setBool(showIncomplete, result);
            },
          ),
          SettingSwitchView(
            title: '仅显示当天的ToDo',
            isOn: _showTodayOnly,
            changeCallBack: (result) async {
              final prefs = await SharedPreferences.getInstance();
              prefs.setBool(showTodayOnly, result);
            },
          ),
        ],
      ),
    );
  }
}
