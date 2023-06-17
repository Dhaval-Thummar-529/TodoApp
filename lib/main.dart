import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:todo_app/Model/TodoModel.dart';
import 'package:todo_app/Service/DatabaseHandler.dart';
import 'package:todo_app/constants/getPages.dart';
import 'package:todo_app/screens/splashScreen.dart';

import 'screens/ToDo.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: Colors.transparent));

    return GetMaterialApp(
      title: "Todo App",
      debugShowCheckedModeBanner: false,
      getPages: getPages,
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const CSplashScreen(),
    );
  }
}
