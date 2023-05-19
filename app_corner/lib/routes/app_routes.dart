part of 'app_pages.dart';

abstract class Routes {
  Routes._();
  static const LOGIN = _Paths.LOGIN;
  static const SIGNUP = _Paths.SIGNUP;
  static const HOME = _Paths.HOME;
  static const YOUR_PETS = _Paths.YOUR_PETS;
  static const ADD_PET = _Paths.ADD_PET;
  static const PROFILE = _Paths.PROFILE;
  static const PET = _Paths.PET;
}

abstract class _Paths {
  _Paths._();
  static const LOGIN = '/login';
  static const SIGNUP = '/signup';
  static const HOME = '/home';
  static const YOUR_PETS = '/yourpets';
  static const ADD_PET = '/addpet';
  static const PROFILE = '/profile';
  static const PET = '/pet';
}