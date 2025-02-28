import 'package:flutter/material.dart';
import 'package:like_todo/page/me/setting_page.dart';
import 'package:tdesign_flutter/tdesign_flutter.dart';

import '../../component/me/me_item_view.dart';

class MePage extends StatelessWidget {
  const MePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: const Size(double.infinity, 120),
        child: SafeArea(
          child: TDNavBar(
            title: '我的',
            useDefaultBack: false,
            backgroundColor: Colors.transparent,
          ),
        ),
      ),
      body: Column(
        children: [
          MeItemView(
            title: '设置',
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return const SettingPage();
              }));
            },
          )
        ],
      ),
    );
  }
}
