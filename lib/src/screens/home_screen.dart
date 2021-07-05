import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todolist/models/todo.dart';
import 'package:todolist/src/controllers/todo_controller.dart';
import 'package:todolist/src/screens/create_todo_screen.dart';
import 'package:todolist/src/screens/edit_todo_screen.dart';
import 'package:todolist/src/screens/history_screen.dart';
import 'package:todolist/src/widgets/todo_cart.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeScreenState();
  }
}

class _HomeScreenState extends State<HomeScreen> {
  TodoController todoController = TodoController();

  @override
  void initState() {
    super.initState();
    todoController.getTodo();
  }

  @override
  Widget build(BuildContext context) {
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
        title: Text(
          'ToDoList',
          style: TextStyle(fontSize: 20),
        ),
        actions: [
          IconButton(
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => HistoryScreen(),
              ),
            ),
            icon: Icon(
              Icons.list,
              color: Colors.white,
              size: 20.0,
            ),
          ),
        ],
      ),
      body: Container(
        child: StreamBuilder(
          stream: todoController.getTodoStream,
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
                    onTap: () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => EditToDoScreen(
                          index: data[index],
                          subTitle: data[index].subTitle,
                          title: data[index].title,
                        ),
                      ),
                    ),
                    child: ToDoCart(
                      todo: data[index],
                      getTodo: () {
                        todoController.getTodo();
                      },
                    ),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}
