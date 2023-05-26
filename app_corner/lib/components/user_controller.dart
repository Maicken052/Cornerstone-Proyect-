import 'package:get/get.dart';

class UserController extends GetxController {
  RxString username = ''.obs;
  RxString email = ''.obs;
  RxString password = ''.obs;

  void setUser(String name, String email_, String password_) {
    username.value = name;
    email.value = email_;
    password.value = password_;
  }

  Map<String, String> getUser() {
    return {'username': username.value, 'email': email.value, 'password': password.value};
  }
}
