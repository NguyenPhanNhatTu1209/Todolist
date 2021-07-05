import 'dart:async';
import 'dart:convert' as convert;
import 'package:todolist/models/todo.dart';
import 'package:todolist/src/repository/todo_repository.dart';

class TodoController {
  TodoRepository todoRepository = TodoRepository();
  StreamController<List<ToDo>> _todoListController =
      StreamController<List<ToDo>>.broadcast();

  getTodo() async {
    List<ToDo> temp = [];
    var res = await todoRepository.getTodo();
    List<dynamic> listJson = convert.jsonDecode(res.body)['data'];
    print(listJson.length);
    listJson.forEach((element) {
      temp.add(ToDo.fromMap(element));
    });
    _todoListController.add(temp);
  }

  done(String idTodo) async {
    var status = await todoRepository.doneTodo({
      "_id": idTodo,
    });
    status == 200 ? print('OKE') : print('Fail!');
  }

  delete(String idTodo) async {
    var status = await todoRepository.deleteTodo({
      "_id": idTodo,
    });
    status == 200 ? print('OKE') : print('Fail!');
  }

  Stream<List<ToDo>> get getTodoStream => _todoListController.stream;
}
