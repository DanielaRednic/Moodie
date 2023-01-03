import 'package:flutter/material.dart';
import 'package:moodie/Screens/Welcome/welcome_screen.dart';
import 'package:moodie/constants.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Moodie Auth',
      theme: ThemeData(
        primaryColor: kPrimaryColor,
        scaffoldBackgroundColor: Color.fromARGB(255, 26, 3, 56),
        //scaffoldBackgroundColor: const Color(0xFFFFFFFF),
      ),
      home: WelcomeScreen(),
    );
  }
}
