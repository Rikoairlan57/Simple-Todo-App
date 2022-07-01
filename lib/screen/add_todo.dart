// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/provider/todos.dart';

class AddTodo extends StatelessWidget {
  const AddTodo({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Todos todos = Provider.of<Todos>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Todo"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
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
                if(todos.titleController.text.isNotEmpty && 
                  todos.descController.text.isNotEmpty)
                  {
                    todos.addTodo();
                    
                  }
                Navigator.pop(context);
              }, 
              child: Text(todos.isLoading ? "Loading..." : "Add"),
            )
          ]
        ),
      )
    );
  }
}