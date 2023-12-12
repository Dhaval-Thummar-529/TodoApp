import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/constants/RouteConstants.dart';
import 'package:todo_app/controllers/AddTodoController.dart';
import 'package:todo_app/customWidgets/customFiled.dart';

class AddTodo extends StatelessWidget {
  AddTodo({super.key});

  final AddTodoController controller = Get.put(AddTodoController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Todo"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(28.0),
          height: MediaQuery.of(context).size.height - (MediaQuery.of(context).padding.bottom + 150),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  CustomImputField(
                    controller: controller.title,
                    hintText: "Enter task here",
                    label: "Enter Task",
                    textInputAction: TextInputAction.next,
                    maxLines: 1,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomImputField(
                    controller: controller.description,
                    hintText: "Enter description here",
                    label: "Enter Description",
                    textInputAction: TextInputAction.done,
                    maxLines: 6,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  DecoratedBox(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey,
                      ),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 8),
                      child: Obx(
                        () => DropdownButton(
                          isDense: true,
                          iconEnabledColor: Colors.blue,
                          value: controller.selectedValue.value,
                          items: controller.dropdownItems,
                          style: const TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.w600,
                          ),
                          onChanged: (String? value) {
                            controller.selectedValue(value!);
                          },
                          isExpanded: true,
                          borderRadius: BorderRadius.circular(8.0),
                          //Todo: Add decoration to this element
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Obx(
                    () => controller.selectedValue.value ==
                            controller.statusList[2]
                        ? Column(
                            children: [
                              const Text(
                                "Percentage Completed",
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: Colors.blue),
                              ),
                              Slider(
                                value: controller.taskProgress.value,
                                onChanged: (newVal) {
                                  controller.taskProgress(newVal.toDouble());
                                  print(newVal);
                                },
                                label: '${controller.taskProgress.value.round()}',
                                semanticFormatterCallback: (double newValue) {
                                  return '${newValue.round()}';
                                },
                                min: 0,
                                max: 100,
                                divisions: 10,
                                activeColor: Colors.blue,
                                inactiveColor: Colors.grey,
                              ),
                            ],
                          )
                        : const SizedBox(),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            const Icon(
                              Icons.date_range,
                              color: Colors.blue,
                            ),
                            TextButton(
                              onPressed: () async {
                                controller.isStart(true);
                                await controller.openDateTimePicker(context);
                              },
                              child: const Text(
                                "Start Date",
                                style:
                                    TextStyle(color: Colors.blue, fontSize: 15),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Expanded(
                        child: SizedBox(
                          width: 20,
                        ),
                      ),
                      Expanded(
                        child: Row(
                          children: [
                            const Icon(
                              Icons.date_range,
                              color: Colors.blue,
                            ),
                            TextButton(
                              onPressed: () {
                                controller.isEnd(true);
                                controller.openDateTimePicker(context);
                              },
                              child: const Text(
                                "End Date",
                                style:
                                    TextStyle(color: Colors.blue, fontSize: 15),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Center(
                          child: Obx(
                            () => Text(
                              controller.startDate.value,
                              style: const TextStyle(
                                  color: Colors.blue, fontSize: 20),
                            ),
                          ),
                        ),
                      ),
                      const Expanded(
                        child: SizedBox(
                          width: 20,
                        ),
                      ),
                      Expanded(
                        child: Center(
                          child: Obx(
                            () => Text(
                              controller.endDate.value,
                              style: const TextStyle(
                                  color: Colors.blue, fontSize: 20),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: MaterialButton(
                      onPressed: () {
                        controller.addToDo(context);
                      },
                      child: const Text(
                        "ADD",
                        style: TextStyle(color: Colors.blue),
                      ),
                    ),
                  ),
                  Expanded(
                    child: MaterialButton(
                      onPressed: () {
                        controller.emptyFields();
                        Get.back();
                      },
                      child: const Text(
                        "CANCEL",
                        style: TextStyle(color: Colors.blue),
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
