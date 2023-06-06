import 'package:get/get.dart';

import '../Model/TodoModel.dart';
import '../Service/DatabaseHandler.dart';

class TodoController extends GetxController{

  //To-do list from database
  late List<TodoModel> todoList;

  //Active list from database
  late Future<List<TodoModel>> activeList;

  //Finished list from database
  late Future<List<TodoModel>> finishedList;

  //Common List with observer
  late List<TodoModel> cList;

  //Database Handler
  late DatabaseHandler handler;

  @override
  void onInit() {
    super.onInit();
    handler = DatabaseHandler();
    cList = [];
    retrieveList();
    activeList = handler.retrieveTodoByStatus("Active");
    finishedList = handler.retrieveTodoByStatus("Finished");
  }

  retrieveList() async {
    cList = await handler.retrieveTodoByStatus("Todo");
  }
}