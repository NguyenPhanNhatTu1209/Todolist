import 'package:flutter/material.dart';
import 'package:todolist/src/screens/history_screen.dart';
import 'package:todolist/src/screens/home_screen.dart';

class App extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _AppState();
  }
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return HistoryScreen();
  }
}
