import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Model/TodoModel.dart';
import '../Service/DatabaseHandler.dart';

class MyTodoAppController extends GetxController{

  //to-do title
  final TextEditingController title = TextEditingController();

  //to-do description
  final TextEditingController description = TextEditingController();

  //To-do list from database
  late List<TodoModel> todoList;

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
    fetchTodo();
    activeList = handler.retrieveTodo("Active");
    finishedList = handler.retrieveTodo("Finished");
  }

  @override
  void dispose() {
    //release the memory allocated to variables
    super.dispose();
    title.dispose();
    description.dispose();
  }

  void addTodoList(BuildContext context){
    FocusManager.instance.primaryFocus!.unfocus();
    if (title.text.isEmpty || description.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Please fill all fields to add task!"),
        duration: Duration(seconds: 3),
      ));
    } else {
      TodoModel todo = TodoModel(
          title: title.value.text,
          description: description.value.text,
          status: "Todo");
      handler.insertTodo(todo);
      fetchTodo();
      emptyFields();
      Get.back();
    }
  }

  fetchTodo() async {
    todoList = await handler.retrieveTodo("Todo");
  }

  void emptyFields(){
    title.text = "";
    description.text = "";
  }

}