import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/controllers/ActiveController.dart';
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

  //Selected Date
  String? selectedDate;

  //startDate boolean
  var isStart = false.obs;

  //startDate variable
  var startDate = "".obs;

  //endDate boolean
  var isEnd = false.obs;

  //endDate variable
  var endDate = "".obs;

  //status dropdown selected value
  var selectedValue = "Status".obs;

  //status List
  List<String> statusList = ["Status","Todo","active"];

  //Task Progress Variable
  var taskProgress = 0.0.obs;

  @override
  void onInit() {
    super.onInit();
    selectedDate = DateTime.now().toString();
  }

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
          initialDate: DateTime.parse(selectedDate!),
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
      selectedDate = pickedDate.toString();
    }
  }

  addToDo(context) {
    try {
      if (title.value.text.isEmpty) {
        CustomSnackBar().showSnackbar("Please add to-do title", context);
      } else if (description.value.text.isEmpty) {
        CustomSnackBar().showSnackbar("Please add to-do description", context);
      } else if (selectedValue.value==statusList[0]) {
        CustomSnackBar().showSnackbar("Please select task status", context);
      } else if (startDate.value.isEmpty) {
        CustomSnackBar().showSnackbar("Please add start date", context);
      } else if (endDate.value.isEmpty) {
        CustomSnackBar().showSnackbar("Please add end date", context);
      } else {
        TodoModel todo = TodoModel(
            title: title.value.text,
            description: description.value.text,
            status: selectedValue.value,
            startDate: startDate.value,
            modifiedDate: "",
            endDate: endDate.value);
        handler.insertTodo(todo);
        if(selectedValue.value==statusList[1]){
          var controller = Get.find<TodoController>();
          controller.fetchTodo();
        } else {
          var controller = Get.find<ActiveController>();
          controller.fetchTodo();
        }
        emptyFields();
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

  List<DropdownMenuItem<String>> get dropdownItems{
    List<DropdownMenuItem<String>> menuItems = [
      DropdownMenuItem(value: statusList[0], child: const Text("Status")),
      DropdownMenuItem(value: statusList[1], child: const Text("Todo")),
      DropdownMenuItem(value: statusList[2], child: const Text("Active")),
    ];
    return menuItems;
  }

  //Todo: show progress selector if dropdown status is active else sizedBox() also change dropdown button decoration
}
