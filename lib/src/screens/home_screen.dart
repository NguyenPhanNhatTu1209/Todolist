import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todolist/models/todo.dart';
import 'package:todolist/src/Controllers/todo_controller.dart';
import 'package:todolist/src/screens/create_todo_screen.dart';
import 'package:todolist/src/screens/edit_todo_screen.dart';
import 'package:todolist/src/screens/history_screen.dart';
import 'package:todolist/src/widgets/todo_cart.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _HomeScreenState();
  }
}

class _HomeScreenState extends State<HomeScreen> {
  TodoController todoController = TodoController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    todoController.getToDo();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => CreateToDoScreen())),
        child: Icon(
          Icons.add,
          color: Colors.white,
          size: 20.0,
        ),
        backgroundColor: Colors.blueAccent,
      ),
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () => Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => HistoryScreen())),
              icon: Icon(
                Icons.list,
                color: Colors.white,
                size: 30.0,
              ))
        ],
        title: Text(
          'ToDoList',
          style: TextStyle(fontSize: 20),
        ),
      ),
      body: Container(
          child: StreamBuilder(
              stream: todoController.getToDoStream,
              builder: (context, AsyncSnapshot snapshot) {
                if (!snapshot.hasData) {
                  return Container(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                } else {
                  List<ToDo> data = snapshot.data;
                  return ListView.builder(
                      padding: EdgeInsets.only(top: 10),
                      itemCount: data.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () =>
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => EditToDoScreen(
                                        index: data[index],
                                        title: data[index].title,
                                        subTitle: data[index].subTitle,
                                      ))),
                          child: ToDoCart(
                            todo: data[index],
                          ),
                        );
                      });
                }
              })),
    );
  }
}
