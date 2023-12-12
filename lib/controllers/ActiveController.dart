import 'package:get/get.dart';
import 'package:todo_app/controllers/FinishedController.dart';
import 'package:todo_app/controllers/MyTodoAppController.dart';

import '../Model/TodoModel.dart';
import '../Service/DatabaseHandler.dart';

class ActiveController extends GetxController{

  //Active list from database
  late List<TodoModel> active;

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
      active = await handler.retrieveTodoByStatus("active");
      checkBoxValueList = List.generate(active.length, (index) => false).obs;
    } catch(e){
      print(e);
      isLoading(false);
    } finally {
      isLoading(false);
    }
  }

  getDateDifference(String startDate, String endDate){
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
            id: active[index].id,
            title: active[index].title,
            description: active[index].description,
            status: "finished",
            startDate: active[index].startDate,
            modifiedDate: DateTime.now().toString().substring(0, 10),
            endDate: active[index].endDate,
            progress: 100);
        handler.updateTodoStatus(activeModel);
        var controller = Get.find<FinishedController>();
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