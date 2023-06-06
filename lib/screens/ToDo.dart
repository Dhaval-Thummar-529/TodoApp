import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Model/TodoModel.dart';
import '../Service/DatabaseHandler.dart';

class ToDo extends StatelessWidget {
  final String todoType;
  ToDo({super.key, required this.todoType});

  late List<TodoModel> todoList = await DatabaseHandler().retrieveTodo(todoType);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: todoList.isNotEmpty
              ? ListView.builder(
                  itemCount: todoList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Card(
                      child: ListTile(
                        contentPadding: const EdgeInsets.all(8),
                        title: Text(todoList[index].title),
                        subtitle: Text(todoList[index].description),
                      ),
                    );
                  })
              : const Center(
                  child: Text(
                    "No task to do!",
                    style: TextStyle(fontSize: 12, color: Colors.black),
                  ),
                ),
        ),
      ),
    );
  }
}
