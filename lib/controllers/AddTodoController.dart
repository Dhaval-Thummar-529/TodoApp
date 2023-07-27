import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/controllers/TodoController.dart';
import 'package:todo_app/customWidgets/customSnackBar.dart';

import '../Model/TodoModel.dart';
import '../Service/DatabaseHandler.dart';

class AddTodoController extends GetxController {
  //to-do title
  final TextEditingController title = TextEditingController();

  //to-do description
  final TextEditingController description = TextEditingController();

  //Database Handler
  late DatabaseHandler handler = DatabaseHandler();

  //Picked Date variable
  DateTime? pickedDate;

  //Formatted Date
  String? formattedDate;

  //startDate boolean
  var isStart = false.obs;

  //startDate variable
  var startDate = "".obs;

  //endDate boolean
  var isEnd = false.obs;

  //endDate variable
  var endDate = "".obs;

  @override
  void dispose() {
    //release the memory allocated to variables
    super.dispose();
    title.dispose();
    description.dispose();
  }

  //function to show datePicker Dialog
  openDateTimePicker(BuildContext context) async {
    FocusManager.instance.primaryFocus!.unfocus();
    try {
      pickedDate = await showDatePicker(
          context: context,
          builder: (data, child) {
            return Theme(
                data: Theme.of(context).copyWith(
                  colorScheme: const ColorScheme.light(
                    primary: Colors.amberAccent, // <-- SEE HERE
                    onPrimary: Colors.redAccent, // <-- SEE HERE
                    onSurface: Colors.blueAccent, // <-- SEE HERE
                  ),
                  textButtonTheme: TextButtonThemeData(
                    style: TextButton.styleFrom(
                      primary: Colors.red, // button text color
                    ),
                  ),
                ),
                child: child!);
          },
          initialDate: DateTime.now(),
          firstDate: DateTime(DateTime.now().year),
          lastDate:
              DateTime(DateTime.now().year + 100)); // Opens DatePicker Dialog
    } catch (e) {
      print("error==>$e");
    }
    if (pickedDate != null) {
      //condition to check whether pickedDate is null or not
      formattedDate = pickedDate.toString().substring(0, 10);
      print(formattedDate!);
      if (formattedDate != null && isStart.value) {
        //condition to check whether formattedDate is not null and isStart date selection
        if (endDate.value.isNotEmpty &&
            DateTime.parse(formattedDate!)
                    .compareTo(DateTime.parse(endDate.value)) <=
                0) {
          //condition to check that EndDate is not null and StartDate is not greater than EndDate
          startDate(formattedDate.toString());
          print("Start Date : ${startDate.value}");
          isStart(false);
        } else if (endDate.value.isEmpty) {
          //condition to check whether EndDate is null
          startDate(formattedDate.toString());
          print("Start Date : ${startDate.value}");
          isStart(false);
        } else {
          CustomSnackBar()
              .showSnackbar("Start Date cannot be after end date!", context);
        }
      } else if (formattedDate != null && isEnd.value) {
        //condition to check whether formattedDate is not null and isEnd date selection
        if (startDate.value.isNotEmpty &&
            DateTime.parse(formattedDate!)
                    .compareTo(DateTime.parse(startDate.value)) >=
                0) {
          //condition to check that StartDate is not null and EndDate is not lesser than StartDate
          endDate(formattedDate.toString());
          print("End Date : ${endDate.value}");
          isEnd(false);
        } else if (startDate.isEmpty) {
          //condition to check whether StartDate is null
          endDate(formattedDate.toString());
          print("End Date : ${endDate.value}");
          isEnd(false);
        } else {
          CustomSnackBar()
              .showSnackbar("End Date cannot be before start date!", context);
        }
      }
    }
  }

  addToDo(context) {
    try {
      if (title.value.text.isEmpty) {
        CustomSnackBar().showSnackbar("Please add to-do title", context);
      } else if (description.value.text.isEmpty) {
        CustomSnackBar().showSnackbar("Please add to-do description", context);
      } else if (startDate.value.isEmpty) {
        CustomSnackBar().showSnackbar("Please add start date", context);
      } else if (endDate.value.isEmpty) {
        CustomSnackBar().showSnackbar("Please add end date", context);
      } else {
        var controller = Get.find<TodoController>();
        TodoModel todo = TodoModel(
            title: title.value.text,
            description: description.value.text,
            status: "Todo",
            startDate: startDate.value,
            modifiedDate: "",
            endDate: endDate.value);
        handler.insertTodo(todo);
        emptyFields();
        controller.fetchTodo();
        Get.back();
      }
    } catch (e) {
      print("error==>$e");
    }
  }

  void emptyFields() {
    title.text = "";
    description.text = "";
  }
}
