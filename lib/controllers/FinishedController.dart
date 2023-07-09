import 'package:get/get.dart';
import 'package:todo_app/controllers/MyTodoAppController.dart';

import '../Model/TodoModel.dart';
import '../Service/DatabaseHandler.dart';

class FinishedController extends GetxController{

  //Finished list from database
  late List<TodoModel> finished;

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
      finished = await handler.retrieveTodoByStatus("finished");
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