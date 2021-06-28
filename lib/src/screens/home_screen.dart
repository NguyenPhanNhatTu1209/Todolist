import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

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
      appBar: AppBar(
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

                  return ListView.builder(
                      padding: EdgeInsets.only(top: 10),
                      itemCount: data.length,
                      itemBuilder: (context, index) {
                        return Container(
                          decoration: BoxDecoration(
                              color: Colors.lightBlue[50],
                              borderRadius: BorderRadius.circular(15),
                              border:
                                  Border.all(color: Colors.white, width: 2)),
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
                                      data[index]['title'].toString(),
                                      style: TextStyle(
                                        color: Colors.redAccent,
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      data[index]['subTitle'].toString(),
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                  flex: 1,
                                  child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(14),
                                        border: Border.all(
                                            color: Colors.green.shade200,
                                            width: 2)),
                                    child: IconButton(
                                      icon: Icon(
                                        Icons.check,
                                        size: 25.0,
                                        color: Colors.green,
                                      ),
                                      onPressed: () => null,
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
                                      onPressed: () => null,
                                    ),
                                  ))
                            ],
                          ),
                        );
                      });
                }
              })),
    );
  }
}
