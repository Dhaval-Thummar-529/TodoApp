import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class AddTodoController extends GetxController {
  //to-do title
  final TextEditingController title = TextEditingController();

  //to-do description
  final TextEditingController description = TextEditingController();

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

  openDateTimePicker(BuildContext context) async {
    try {
      pickedDate = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(DateTime
              .now()
              .year),
          lastDate: DateTime(DateTime
              .now()
              .year + 100));
    }catch(e){
      print("error==>$e");
    }
    if (pickedDate != null) {
      formattedDate = pickedDate.toString().substring(0, 10);
      if (formattedDate != null && isStart.value) {
        startDate = formattedDate.toString() as RxString;
        print(startDate);
        isStart(false);
      } else if (formattedDate != null && isEnd.value) {
        endDate = formattedDate.toString() as RxString;
        print(endDate);
        isEnd(false);
      }
    }
  }
}
