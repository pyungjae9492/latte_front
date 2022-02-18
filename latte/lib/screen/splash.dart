import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'; 
import 'login.dart';

class LatteSplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final width = ScreenUtil().setWidth(360);
    final height = ScreenUtil().setHeight(690);
    return AnimatedSplashScreen(
      splash: Image.asset('asset/image/splash.png'),
      nextScreen: LoginPage(),
      splashTransition: SplashTransition.fadeTransition,
      splashIconSize: height,
      backgroundColor: Color(0xFF91A7FF),
      duration: 2000,
    );
  }
  
}