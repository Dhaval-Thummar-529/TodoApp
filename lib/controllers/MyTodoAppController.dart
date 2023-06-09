import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/controllers/TodoController.dart';

import '../Model/TodoModel.dart';
import '../Service/DatabaseHandler.dart';

class MyTodoAppController extends GetxController {
  //to-do title
  final TextEditingController title = TextEditingController();

  //to-do description
  final TextEditingController description = TextEditingController();

  //Database Handler
  late DatabaseHandler handler;

  //To-do list from database
  late Future<List<TodoModel>> todoList;

  //Active list from database
  late Future<List<TodoModel>> activeList;

  //Finished list from database
  late Future<List<TodoModel>> finishedList;

  var isLoading = false.obs;
  var isGettingUpdated = false.obs;

  @override
  void onInit() {
    //initialize on starting of the screen
    super.onInit();
    handler = DatabaseHandler();
    todoList = retrieveList();
    activeList = handler.retrieveTodoByStatus("Active");
    finishedList = handler.retrieveTodoByStatus("Finished");
  }

  @override
  void dispose() {
    //release the memory allocated to variables
    super.dispose();
    title.dispose();
    description.dispose();
  }

  void addTodoList(BuildContext context) {
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
      isGettingUpdated(true);
      try {
        handler.insertTodo(todo);
        TodoController().todoList = fetchTodo();
        Get.back();
      } catch (e) {
        print("error==> $e");
        isGettingUpdated(false);
      } finally {
        isGettingUpdated(false);
      }
    }
  }

  void emptyFields() {
    title.text = "";
    description.text = "";
  }

  Future<List<TodoModel>> retrieveList() async {
    isLoading(true);
    List<TodoModel> list = [];
    try {
      list = await handler.retrieveTodoByStatus("Todo");
    } catch (e) {
      print(e);
      isLoading(false);
    } finally {
      isLoading(false);
    }
    return list;
  }

  Future<List<TodoModel>> fetchTodo() async{
    return await MyTodoAppController().todoList;
  }
}
