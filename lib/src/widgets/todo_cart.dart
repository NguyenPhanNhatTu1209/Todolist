import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todolist/models/todo.dart';
import 'package:todolist/src/Controllers/todo_controller.dart';

class ToDoCart extends StatefulWidget {
  final ToDo todo;
  ToDoCart({required this.todo});
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
  }

  TodoController todoController = TodoController();

  doneTask() async {
    todoController.done(widget.todo.id);
  }

  cancelTask() async {
    todoController.delete(widget.todo.id);
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
      margin: EdgeInsets.only(top: 8),
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
                  widget.todo.title,
                  style: TextStyle(
                    color: Colors.redAccent,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  widget.todo.subTitle,
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
