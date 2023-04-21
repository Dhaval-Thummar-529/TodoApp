import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Model/TodoModel.dart';

class ToDo extends StatefulWidget {
  Future<List<TodoModel>> todoList;

  ToDo({super.key, required this.todoList});

  @override
  _Todo createState() => _Todo(todoList: todoList);
}

class _Todo extends State<ToDo> {
  Future<List<TodoModel>> todoList;

  _Todo({required this.todoList});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: FutureBuilder(
              future: todoList,
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
