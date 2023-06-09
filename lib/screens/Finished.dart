import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/controllers/TodoController.dart';

import '../Model/TodoModel.dart';
import '../Service/DatabaseHandler.dart';

class Finished extends StatelessWidget {
  final Future<List<TodoModel>> finishedList;
  Finished({super.key, required this.finishedList});

  final TodoController controller = Get.put(TodoController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: FutureBuilder(
              future: finishedList,
              builder: (BuildContext context,
                  AsyncSnapshot<List<TodoModel>> snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Card(
                          child: ListTile(
                            contentPadding: const EdgeInsets.all(8),
                            title: Text(snapshot.data![index].title),
                            subtitle: Text(snapshot.data![index].description),
                          ),
                        );
                      });
                } else {
                  return const Center(
                    child: Text(
                      "No task to do!",
                      style: TextStyle(fontSize: 12, color: Colors.black),
                    ),
                  );
                }
              }),
        ),
      ),
    );
  }
}
