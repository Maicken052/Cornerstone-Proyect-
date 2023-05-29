import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:developer';

class RequestUtil{
  final endpoint = 'https://petfeed-container.euqb4jc9s71os.us-east-1.cs.amazonlightsail.com/';  //URL del restAPI

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

  Future<http.Response> addCat(name, birthdate, weight, userEmail) async {
    return http.post(Uri.parse('${endpoint}pet/add/'),
    body: json.encode({
      "name":name,
      "birthdate":birthdate,
      "weight":weight,
      "user_email":userEmail
      }),
    headers: {
      'Content-Type': 'application/json'
      }
    );
  }

  Future<http.Response> getPets(userEmail) async {
    return http.get(Uri.parse('${endpoint}pet/all-pets/$userEmail'));
  }
}