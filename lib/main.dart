import 'package:flutter/material.dart';
import 'package:movies_app/Home_screen/home_screen.dart';
import 'package:movies_app/My_theme/my_theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: HomeScreen.routeName,
      routes: {HomeScreen.routeName: (context) => const HomeScreen()},
      debugShowCheckedModeBanner: false,
      theme: MyTheme.lightTheme,
    );
  }
}
