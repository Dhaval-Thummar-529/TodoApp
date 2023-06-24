import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/constants/RouteConstants.dart';
import 'package:todo_app/controllers/TodoController.dart';

import '../Model/TodoModel.dart';
import '../Service/DatabaseHandler.dart';

class MyTodoAppController extends GetxController {

  //Database Handler
  late DatabaseHandler handler = DatabaseHandler();

  @override
  void onInit() {
    super.onInit();
  }

}
