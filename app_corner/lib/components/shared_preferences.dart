import 'package:shared_preferences/shared_preferences.dart';

// Guardar información del usuario
Future<void> saveUserData(String username, String email, String password) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString('username', username);
  prefs.setString('email', email);
  prefs.setString('password', password);
}

// Obtener información del usuario
Future<Map<String, String>> getUserData() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String username = prefs.getString('username')!;
  String email = prefs.getString('email')!;
  String password = prefs.getString('password')!;
  return {'username': username, 'email': email, 'password': password};
}

Future<String> getUsername() async {
  Map<String, String> userData = await getUserData();
  String username = userData['username']!;
  return username;
}