import 'package:get/get.dart';
import '../controllers/pets_controller.dart';

class PetsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PetsController>(
      () => PetsController(),
    );
  }
}