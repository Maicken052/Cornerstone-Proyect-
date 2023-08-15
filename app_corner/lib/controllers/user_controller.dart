import 'package:get/get.dart';

class UserController extends GetxController {
  RxString username = ''.obs;
  RxString email = ''.obs;
  RxString password = ''.obs;

  void setUser(String name, String email, String password) {
    username.value = name;
    this.email.value = email;
    this.password.value = password;
  }
}
