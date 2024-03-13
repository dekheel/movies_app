import 'package:flutter/material.dart';
import 'package:another_flutter_splash_screen/another_flutter_splash_screen.dart';
import 'package:movies_app/Myhomepage.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: FlutterSplashScreen.fadeIn(
        backgroundImage:  const Image(image: AssetImage("assets/images/splash_screen.jpg")),
    duration: Duration(seconds: 10),
    childWidget: SizedBox(),
    onAnimationEnd: () => debugPrint("On Fade In End"),
    nextScreen: Myhomepage(),
        ),
    );
  }
}


