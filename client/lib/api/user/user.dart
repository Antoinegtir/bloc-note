import 'package:bonus/api/url.dart';
import 'package:bonus/model/token.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

Future<String> getUser(String token) async {
  String url = "$apiUrl/user";
  Map<String, String> headers = {
    "Authorization": "Bearer $token",
  };
  http.Response response = await http.get(Uri.parse(url), headers: headers);
  if (response.statusCode == 200) {
    return (response.body);
  } else {
    return ('Erreur: ${response.statusCode}');
  }
}

Future<String> getUserTodos(String token) async {
  var url = Uri.parse('$apiUrl/user/todos');
  var response =
      await http.get(url, headers: {'Authorization': 'Bearer $token'});
  return (response.body);
}

Future<String> getId(String token) async {
  var url = Uri.parse('$apiUrl/userId');
  var response =
      await http.get(url, headers: {'Authorization': 'Bearer $token'});
  return (response.body);
}

Future<String> getUserById(String token, String id) async {
  var url = Uri.parse('$apiUrl/users/$id');
  var response =
      await http.get(url, headers: {'Authorization': 'Bearer $token'});
  return (response.body);
}

Future<String> updateUser(String token, String id, String email, String name,
    String firstname, String password) async {
  var url = Uri.parse('$apiUrl/users/$id');
  var body = {
    'email': email,
    'name': name,
    'firstname': firstname,
    'password': password,
  };

  var response = await http
      .put(url, body: body, headers: {'Authorization': 'Bearer $token'});
  return (response.body);
}

Future<String> deleteUser(String token, String id) async {
  var url = Uri.parse('$apiUrl/users/$id');
  var response =
      await http.delete(url, headers: {'Authorization': 'Bearer $token'});
  return (response.body);
}
