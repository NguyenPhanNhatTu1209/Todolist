import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todolist/models/todo.dart';
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
              stream: FirebaseFirestore.instance
                  .collection('todos')
                  .where('status', isEqualTo: 'DOING')
                  .orderBy('createdAt')
                  .snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return Container();
                } else {
                  var data = snapshot.data!.docs;
                  print('TuData: ' + data[0]['title'].toString());
                  return ListView.builder(
                      padding: EdgeInsets.only(top: 10),
                      itemCount: data.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () =>
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => EditToDoScreen(
                                        index: data[index].reference,
                                        title: data[index]['title'],
                                        subTitle: data[index]['subTitle'],
                                      ))),
                          child: ToDoCart(
                            todo: ToDo.fromFirestore(data[index]),
                            index: data[index].reference,
                          ),
                        );
                      });
                }
              })),
    );
  }
}
