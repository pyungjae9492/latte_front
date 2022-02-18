import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'quest_list.dart';
import 'profile.dart';
import '../widget/bottom_bar.dart';
import '../model/model_user.dart';

class TabViewWrapper extends StatefulWidget {
  @override
  _TabViewWrapperState createState() => _TabViewWrapperState();
}

class _TabViewWrapperState extends State<TabViewWrapper> {
  
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
          child:
            DefaultTabController(
            initialIndex: 1,
            length: 2,
            child: Scaffold(
              bottomNavigationBar: Bottom(), 
              body: TabBarView(
                physics: NeverScrollableScrollPhysics(),
                children: <Widget>[
                  Profile(),
                  QuestList(),
                ],
              ),
            ),
          ), 
        );
  }
}
