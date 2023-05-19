import 'package:get/get.dart';
import 'package:app_corner/bindings/pets_binding.dart';  
import 'package:app_corner/pages/login.dart';
import 'package:app_corner/pages/sign_up.dart';
import 'package:app_corner/pages/home.dart';
import 'package:app_corner/pages/add_pet.dart';
import 'package:app_corner/pages/profile.dart';
import 'package:app_corner/pages/your_pets.dart';
import 'package:app_corner/pages/pet.dart';

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
      page: () => const Login(),
    ),

    GetPage(
      name: _Paths.SIGNUP,
      page: () => const SignUp(),
    ),

    GetPage(
      name: _Paths.HOME,
      page: () => const Home(),
    ),

    GetPage(
      name: _Paths.YOUR_PETS,
      page: () => const YourPets(),
      binding: PetsBinding()
    ),

    GetPage(
      name: _Paths.ADD_PET,
      page: () => const AddPet(),
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
