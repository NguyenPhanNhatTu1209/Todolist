import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class EditToDoScreen extends StatefulWidget {
  final index;
  final String title;
  final String subTitle;
  EditToDoScreen(
      {required this.index, required this.title, required this.subTitle});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _EditToDoScreenState();
  }
}

class _EditToDoScreenState extends State<EditToDoScreen> {
  String title = "";
  String subTitle = "";
  TextEditingController _titleController = TextEditingController();
  TextEditingController _subTitleController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(widget.title);
    print(widget.subTitle);
    _titleController.text = widget.title;
    _subTitleController.text = widget.subTitle;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Edit Task',
          style: TextStyle(fontSize: 20),
        ),
      ),
      body: SafeArea(
        minimum: const EdgeInsets.only(left: 20, right: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            TextField(
              controller: _titleController,
              onChanged: (text) {
                setState(() {
                  title = text.trim();
                });
              },
              decoration: InputDecoration(labelText: 'Title'),
              style: TextStyle(fontSize: 18, color: Colors.black),
            ),
            TextField(
              controller: _subTitleController,
              onChanged: (text) {
                setState(() {
                  subTitle = text.trim();
                });
              },
              decoration: InputDecoration(labelText: 'SubTitle'),
              style: TextStyle(fontSize: 14, color: Colors.black),
            ),
            SizedBox(
              height: 20,
            ),
            GestureDetector(
              onTap: () async {
                await FirebaseFirestore.instance
                    .runTransaction((transaction) async {
                  transaction.update(widget.index, {
                    "title": title,
                    "subTitle": subTitle,
                    "status": "DOING",
                    "createdAt": DateTime.now(),
                  });
                });
                // Navigator.of(context).pop();
                Navigator.pop(context);
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                decoration: BoxDecoration(
                    color: Colors.blue,
                    border: Border.all(color: Colors.yellow, width: 2),
                    borderRadius: BorderRadius.circular(5)),
                child: Text(
                  'Edit Task',
                  style: TextStyle(fontSize: 20, color: Colors.red),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
