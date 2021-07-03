import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todolist/models/todo.dart';

class ToDoCart extends StatefulWidget {
  final data;
  final index;
  ToDoCart({required this.data, required this.index});
  @override
  State<StatefulWidget> createState() {
    return _ToDoCart();
  }
}

class _ToDoCart extends State<ToDoCart> {
  ToDo? todo;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    todo = ToDo.fromFirestore(widget.data);
  }

  doneTask() async {
    await FirebaseFirestore.instance.runTransaction((transaction) async {
      transaction.update(widget.index, {'status': 'DONE'});
    });
  }

  cancelTask() async {
    await FirebaseFirestore.instance.runTransaction((transaction) async {
      transaction.update(widget.index, {'status': 'CANCEL'});
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      decoration: BoxDecoration(
          color: Colors.lightBlue[50],
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: Colors.blue.shade200, width: 2)),
      padding: EdgeInsets.only(left: 24, right: 8),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.only(right: 10),
            child: Icon(
              Icons.timer,
              color: Colors.blue,
              size: 25,
            ),
          ),
          Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  todo!.title,
                  style: TextStyle(
                    color: Colors.redAccent,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  todo!.subTitle,
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
                ),
              ],
            ),
          ),
          Expanded(
              flex: 1,
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: Colors.green.shade200, width: 2)),
                child: IconButton(
                  icon: Icon(
                    Icons.check,
                    size: 25.0,
                    color: Colors.green,
                  ),
                  onPressed: () => doneTask(),
                ),
              )),
          Expanded(
              flex: 1,
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(
                      color: Colors.red.shade200,
                      width: 2,
                    )),
                child: IconButton(
                  icon: Icon(
                    Icons.close,
                    size: 25.0,
                    color: Colors.red,
                  ),
                  onPressed: () => cancelTask(),
                ),
              ))
        ],
      ),
    );
  }
}
