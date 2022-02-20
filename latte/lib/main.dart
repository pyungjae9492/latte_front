import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'screen/splash.dart';
import 'screen/tab_view_wrapper.dart';
import 'package:get/get.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
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
        GetMaterialApp(
        title: 'Latte',
        theme: ThemeData(
          brightness: Brightness.light,
          primaryColor: Colors.black,
        ),
        home: LatteSplashScreen()
        // home: TabViewWrapper()
      )
    );
  }
}
