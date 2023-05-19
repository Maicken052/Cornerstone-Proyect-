import 'package:http/http.dart' as http;
import 'dart:convert';

class RequestUtil{
  final endpoint = 'https://petfeed-container.euqb4jc9s71os.us-east-1.cs.amazonlightsail.com/';

  Future<http.Response> register(user, email, password) async {
    return http.post(Uri.parse('${endpoint}users/register/'),
    body: json.encode({
      "password":password,
      "email":email,
      "user":user
      }),
    headers: {
      'Content-Type': 'application/json'
      }
    );
  }

  Future<http.Response> login(username, password) async {
    return http.post(Uri.parse('${endpoint}token'),
    body: {
      "username":username, 
      "password":password
      }
    );
  }
  Future<http.Response> getName(email) async {
    return http.post(Uri.parse('${endpoint}users/me/'),
    body: json.encode({
      "email":email
      }),
    headers: {
      'Content-Type': 'application/json'
      }
    );
  }
}