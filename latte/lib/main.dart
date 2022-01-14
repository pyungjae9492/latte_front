import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import './widget/bottom_bar.dart';
import 'quest_list.dart';
import 'profile.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit( 
      designSize: const Size(360,690),
      minTextAdapt: true,
      builder: () =>
        MaterialApp(
        title: 'Latte',
        theme: ThemeData(
          brightness: Brightness.light,
          primaryColor: Colors.black,
        ),
        home: SafeArea(
          child:
            DefaultTabController(
            initialIndex: 1,
            length: 2,
            child: Scaffold(
              body: TabBarView(
                physics: NeverScrollableScrollPhysics(),
                children: <Widget>[
                  Profile(),
                  QuestList(),
                ],
              ),
              bottomNavigationBar: Bottom(), 
            ),
          ), 
        )
      )
    );
  }
}
