import 'package:flutter/material.dart';

class CreateToDoScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _CreateToDoScreenState();
  }
}

class _CreateToDoScreenState extends State<CreateToDoScreen> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Add Task',
          style: TextStyle(fontSize: 20),
        ),
      ),
      body: SafeArea(
        minimum: const EdgeInsets.only(left: 20, right: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            TextField(
              decoration: InputDecoration(labelText: 'Title'),
              style: TextStyle(fontSize: 18, color: Colors.black),
            ),
            TextField(
              decoration: InputDecoration(labelText: 'SubTitle'),
              style: TextStyle(fontSize: 14, color: Colors.black),
            ),
            Padding(padding: const EdgeInsets.symmetric(vertical: 10)),
            ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: Stack(
                children: <Widget>[
                  Positioned.fill(
                    child: Container(
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          colors: <Color>[
                            Color(0xFF0D47A1),
                            Color(0xFF1976D2),
                            Color(0xFF42A5F5),
                          ],
                        ),
                      ),
                    ),
                  ),
                  TextButton(
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.all(16.0),
                      primary: Colors.white,
                      textStyle: const TextStyle(fontSize: 16),
                    ),
                    onPressed: () {},
                    child: const Text('Add Task'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
