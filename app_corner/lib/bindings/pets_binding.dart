import 'package:get/get.dart';
import 'package:app_corner/Components/pets_controller.dart';

class PetsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PetsController>(
      () => PetsController(),
    );
  }
}