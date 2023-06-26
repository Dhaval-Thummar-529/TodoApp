import 'package:get/get.dart';
import 'package:todo_app/controllers/MyTodoAppController.dart';

import '../Model/TodoModel.dart';
import '../Service/DatabaseHandler.dart';

class TodoController extends GetxController{

  //To-do list from database
  late List<TodoModel> todoList;

  //Observable variable for Loader
  var isLoading = false.obs;

  //Database Handler
  late DatabaseHandler handler = DatabaseHandler();

  @override
  void onInit() {
    super.onInit();
    handler = DatabaseHandler();
    fetchTodo();
  }

  fetchTodo() async {
    isLoading(true);
    try {
      todoList = await handler.retrieveTodoByStatus("Todo");
    } catch(e){
      print(e);
      isLoading(false);
    } finally {
      isLoading(false);
    }
  }

}