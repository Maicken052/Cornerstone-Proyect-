import 'package:get/get.dart';
import '../bindings/pets_binding.dart';   
import '../pages/login.dart';
import '../pages/sign_up.dart';
import '../pages/home.dart';
import '../pages/add_pet.dart';
import '../pages/profile.dart';
import '../pages/your_pets.dart';
import '../pages/pet.dart';
part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const LOGIN = Routes.LOGIN;
  static const SIGNUP = Routes.SIGNUP;
  static const HOME = Routes.HOME;
  static const YOUR_PETS = Routes.YOUR_PETS;
  static const ADD_PET = Routes.ADD_PET;
  static const PROFILE = Routes.PROFILE;
  static const PET = Routes.PET;

  static final routes = [
    GetPage(
      name: _Paths.LOGIN,
      page: () => Login(),
    ),

    GetPage(
      name: _Paths.SIGNUP,
      page: () => SignUp(),
    ),

    GetPage(
      name: _Paths.HOME,
      page: () => Home(),
    ),

    GetPage(
      name: _Paths.YOUR_PETS,
      page: () => YourPets(),
      binding: PetsBinding()
    ),

    GetPage(
      name: _Paths.ADD_PET,
      page: () => AddPet(),
      binding: PetsBinding()
    ),

    GetPage(
      name: _Paths.PROFILE,
      page: () => const Profile(),
    ),

    GetPage(
      name: _Paths.PET,
      page: () => const Pet(),
    ),
  ];
}
