import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';
import 'MyTodoApp.dart';

class CSplashScreen extends StatefulWidget{
  const CSplashScreen({super.key});

  @override
  State<StatefulWidget> createState() => _CSplashScreen();

}

class _CSplashScreen extends State<CSplashScreen>{

  @override
  Widget build(BuildContext context) {
    return SplashScreen(
      backgroundColor: Colors.blue,
      seconds: 3,
      navigateAfterSeconds: MyTodoApp(),
    );
  }

}