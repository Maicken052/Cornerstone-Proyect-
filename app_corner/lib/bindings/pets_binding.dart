import 'package:get/get.dart';
import '../components/pets_controller.dart';

class PetsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PetsController>(
      () => PetsController(),
    );
  }
}