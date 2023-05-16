import 'package:bonus/api/url.dart';
import 'package:http/http.dart' as http;

Future<String> registerUser(
    String email, String name, String firstname, String password) async {
  var url = Uri.parse('$apiUrl/register');
  var body = {
    'email': email,
    'name': name,
    'firstname': firstname,
    'password': password,
  };

  var response = await http.post(url, body: body);
  return (response.body);
}

Future<String> loginUser(String email, String password) async {
  var url = Uri.parse('$apiUrl/login');
  var body = {
    'email': email,
    'password': password,
  };

  var response = await http.post(url, body: body);
  return (response.body);
}
