import 'package:get/get.dart';
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

}