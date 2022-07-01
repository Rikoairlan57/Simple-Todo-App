// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/screen/add_todo.dart';
import 'package:todo_app/screen/edit_todo.dart';
import 'package:todo_app/provider/todos.dart';

class TodoScreen extends StatefulWidget {
  const TodoScreen({ Key? key }) : super(key: key);

  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  @override
  Widget build(BuildContext context) {
    Todos todos = Provider.of<Todos>(context);
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(
            context, MaterialPageRoute(
              builder: (context) => ChangeNotifierProvider(
                create: (context) => Todos(),
                child: AddTodo()
              ),
            ),
          ).then((value) => setState((){}));

        },
        child: Icon(Icons.add_task),
      ),
      appBar: AppBar(
        title: Text("Todo App"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: FutureBuilder(
          future: todos.getTodo(),
          builder: (context, snapsot){
            if (todos.itemTodo.isEmpty) {
              return Center(
                child: Text("Your List Empty")
              );
            }
           if(snapsot.connectionState == ConnectionState.waiting){
            return Center(
              child: CircularProgressIndicator()
            );
           } else{
             return ListView.builder(
              itemCount: todos.itemTodo.length,
              itemBuilder: (context, index){
                final todo = todos.itemTodo[index];
                return GestureDetector(
                  onTap: (){
                    Navigator.push(
                      context, MaterialPageRoute(
                        builder: (context) => ChangeNotifierProvider(
                          create: (context) => Todos(),
                          child: EditTodo(
                            id: todo.id, 
                            title: todo.title,
                            description: todo.description
                          )
                        ),
                      )
                    ).then((value) => setState((){}));
                  },
                  child: ListTile(
                    subtitle: Text(todo.description),
                    title: Text(todo.title),
                    trailing: IconButton(
                      onPressed: (){
                        todos.deleteTodo(todo.id);
                        setState(() {
                          
                        });
                      }, 
                      icon: Icon(Icons.delete, color: Colors.red,)),
                  ),
                );
              }
            );
           }
          }
        ),
      ),
    );
  }
}