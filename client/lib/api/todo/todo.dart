import 'package:bonus/api/url.dart';
import 'package:http/http.dart' as http;

Future<String> fetchTodos(String token) async {
  var url = Uri.parse('$apiUrl/todos');
  var headers = {'Authorization': 'Bearer $token'};

  var response = await http.get(url, headers: headers);
  return (response.body);
}

Future<String> fetchTodoById(String token, int id) async {
  var url = Uri.parse('$apiUrl/todos/$id');
  var headers = {'Authorization': 'Bearer $token'};

  var response = await http.get(url, headers: headers);
  return (response.body);
}

Future<String> createTodo(String token, String title, String description,
    String dueTime, String status, String userId) async {
  var url = Uri.parse('$apiUrl/todos');
  var headers = {'Authorization': 'Bearer $token'};
  var body = {
    'title': title,
    'description': description,
    'due_time': dueTime,
    'user_id': userId,
    'status': status,
  };

  var response = await http.post(url, headers: headers, body: body);
  return (response.body);
}

Future<String> updateTodo(String token, String id, String title,
    String description, String dueTime, String todo, String userId) async {
  var url = Uri.parse('$apiUrl/todos/$id');
  var headers = {'Authorization': 'Bearer $token'};
  var body = {
    'title': title,
    'description': description,
    'due_time': dueTime,
    'status': todo,
    'user_id': userId,
  };

  var response = await http.put(url, headers: headers, body: body);
  print(response.body);
  return (response.body);
}

Future<String> deleteTodo(String token, String id) async {
  var url = Uri.parse('$apiUrl/todos/$id');
  var headers = {'Authorization': 'Bearer $token'};

  var response = await http.delete(url, headers: headers);
  return (response.body);
}
