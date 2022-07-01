// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/provider/todos.dart';

class EditTodo extends StatelessWidget {
  EditTodo({ 
    Key? key, 
    required this.id, 
    required this.title, 
    required this.description
    }) : super(key: key);
  int id;
  String title;
  String description;

  @override
  Widget build(BuildContext context) {
    Todos todos = Provider.of<Todos>(context);

    todos.titleController.text = title;
    todos.descController.text = description;
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Todo"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: todos.titleController,
              decoration: InputDecoration(
                border: OutlineInputBorder()
              )
            ),
            SizedBox(
              height: 20,
            ),
            TextField(
              controller: todos.descController,
              decoration: InputDecoration(
                border: OutlineInputBorder()
              )
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: (){
                todos.editData(id);
                Navigator.pop(context);
              }, 
              child: Text("Edit"),
            )
          ]
        ),
      )
    );
  }
}