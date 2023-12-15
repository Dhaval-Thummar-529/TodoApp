import 'package:get/get.dart';
import 'package:todo_app/controllers/MyTodoAppController.dart';

import '../Model/TodoModel.dart';
import '../Service/DatabaseHandler.dart';

class FinishedController extends GetxController {
  //Finished list from database
  late List<TodoModel> finished;

  //Observable variable for Loader
  var isLoading = false.obs;

  //Database Handler
  late DatabaseHandler handler = DatabaseHandler();

  var toDoTaskPercentage = 0.0.obs;

  //All To-do list from database
  late List<TodoModel> allTodoList;

  @override
  void onInit() {
    super.onInit();
    handler = DatabaseHandler();
    fetchTodo();
  }

  fetchTodo() async {
    isLoading(true);
    try {
      finished = await handler.retrieveTodoByStatus("finished");
      allTodoList = await handler.retrieveAllTodo();
    } catch (e) {
      print(e);
      isLoading(false);
    } finally {
      if (finished.isNotEmpty) {
        toDoTaskPercentage(((finished.length / allTodoList.length) * 100).toPrecision(2));
      }
      isLoading(false);
    }
  }
}
