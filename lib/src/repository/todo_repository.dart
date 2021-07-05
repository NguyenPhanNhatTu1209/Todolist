import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

const String baseUrl = 'todolist-cosy.herokuapp.com';

class TodoRepository {
  Future<http.Response> getTodo() async {
    var response = await http.get(Uri.https(
      baseUrl,
      '/task/show-task',
    ));

    return response;
  }

  Future<int> addTodo(Map<String, String> todoJson) async {
    var response = await http.post(
      Uri.https(
        baseUrl,
        '/task/create-task',
      ),
      body: convert.jsonEncode(todoJson),
    );
    return response.statusCode;
  }

  Future<int> deleteTodo(Map<String, String> body) async {
    var response = await http.put(
      Uri.https(
        baseUrl,
        '/task/delete-task',
      ),
      body: convert.jsonEncode(body),
    );
    return response.statusCode;
  }

  Future<int> doneTodo(Map<String, String> body) async {
    var response = await http.put(
      Uri.https(
        baseUrl,
        '/task/done-task',
      ),
      body: convert.jsonEncode(body),
      headers: {
        'Content-Type': 'application/json',
      },
    );
    print(body.toString());
    print('lambiengcode: ' + response.body.toString());
    return response.statusCode;
  }
}
