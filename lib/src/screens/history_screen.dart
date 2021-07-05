import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todolist/src/screens/create_todo_screen.dart';
import 'package:todolist/src/widgets/todo_cart.dart';
import 'package:todolist/src/widgets/todo_cart_history.dart';

class HistoryScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _HistoryScreenState();
  }
}

class _HistoryScreenState extends State<HistoryScreen> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'History',
          style: TextStyle(fontSize: 20),
        ),
      ),
      body: Container(
          child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('todos')
                  .where('status', isEqualTo: 'DONE')
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
                        return ToDoCartHistory(
                          data: data[index],
                          index: data[index].reference,
                        );
                      });
                }
              })),
    );
  }
}
