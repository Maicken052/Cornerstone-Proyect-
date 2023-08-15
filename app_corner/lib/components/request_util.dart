import 'package:http/http.dart' as http;
import 'dart:convert';

class RequestUtil{
  final String endpoint = 'https://petfeed-container.euqb4jc9s71os.us-east-1.cs.amazonlightsail.com/';  //URL del restAPI

  Future<http.Response> register(String user, String email, String password) async{
    return http.post(Uri.parse('${endpoint}users/register/'),
    body: json.encode({
      "password": password,
      "email": email,
      "user": user
      }),
    headers: {
      'Content-Type': 'application/json'
      }
    );
  }

  Future<http.Response> login(String username, String password) async{
    return http.post(Uri.parse('${endpoint}token'),
    body: {
      "username": username, 
      "password": password
      }
    );
  }

  Future<http.Response> getName(String email) async{
    return http.post(Uri.parse('${endpoint}users/me/'),
    body: json.encode({
      "email": email
      }),
    headers: {
      'Content-Type': 'application/json'
      }
    );
  }

  Future<http.Response> addCat(String name, String birthdate, String weight, String email) async{
    return http.post(Uri.parse('${endpoint}pet/add/'),
    body: json.encode({
      "name": name,
      "birthdate": birthdate,
      "weight": weight,
      "user_email": email
      }),
    headers: {
      'Content-Type': 'application/json'
      }
    );
  }

  Future<http.Response> getPets(String email) async {
    return http.get(Uri.parse('${endpoint}pet/all-pets/$email'));
  }
}