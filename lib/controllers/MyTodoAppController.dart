import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Model/TodoModel.dart';
import '../Service/DatabaseHandler.dart';

class MyTodoAppController extends GetxController{

  //to-do title
  final TextEditingController _title = TextEditingController();

  //to-do description
  final TextEditingController _description = TextEditingController();

  //To-do list from database
  late Future<List<TodoModel>> todoList;

  //Active list from database
  late Future<List<TodoModel>> activeList;

  //Finished list from database
  late Future<List<TodoModel>> finishedList;

  //Database Handler
  late DatabaseHandler handler;

  @override
  void onInit() {
    //initialize on starting of the screen
    super.onInit();
    handler = DatabaseHandler();
    todoList = handler.retrieveTodo("Todo");
    activeList = handler.retrieveTodo("Active");
    finishedList = handler.retrieveTodo("Finished");
  }


}