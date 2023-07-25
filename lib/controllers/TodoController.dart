import 'package:get/get.dart';
import 'package:todo_app/controllers/ActiveController.dart';
import 'package:todo_app/controllers/MyTodoAppController.dart';

import '../Model/TodoModel.dart';
import '../Service/DatabaseHandler.dart';

class TodoController extends GetxController {
  //To-do list from database
  late List<TodoModel> todoList;

  //Observable variable for Loader
  var isLoading = false.obs;

  //Database Handler
  late DatabaseHandler handler = DatabaseHandler();

  //Observable variable for UpdatingTask
  var isTaskUpdating = false.obs;

  var checkBoxValueList = List.generate(0, (index) => false).obs;

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
      checkBoxValueList = List.generate(todoList.length, (index) => false).obs;
    } catch (e) {
      print(e);
      isLoading(false);
    } finally {
      isLoading(false);
    }
  }

  getDateDifference(String startDate, String endDate) {
    var sDate = DateTime.now();
    var eDate = DateTime.parse(endDate);
    var difference = eDate.difference(sDate).inDays;
    print(difference);
    return difference;
  }

  updateTaskToActive(int index) {
    /*isTaskUpdating(true);*/
    Future.delayed(const Duration(seconds: 3), () {
      try {
        TodoModel activeModel = TodoModel(
          id: todoList[index].id,
            title: todoList[index].title,
            description: todoList[index].description,
            status: "active",
            startDate: todoList[index].startDate,
            modifiedDate: todoList[index].modifiedDate,
            endDate: todoList[index].endDate);
        handler.updateTodoStatus(activeModel);
        var controller = Get.find<ActiveController>();
        controller.fetchTodo();
        /*isTaskUpdating(false);*/
      } catch (e) {
        print("Exception : $e");
        /*isTaskUpdating(false);*/
      } finally {
        /*isTaskUpdating(false);*/
        fetchTodo();
      }
    });
  }
}
