import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:app_corner/Models/cat_model.dart'; 

class PetsController extends GetxController {

  Rx<List<Cat>> cats = Rx<List<Cat>>([]);
  TextEditingController nameTextEditingController = TextEditingController();
  TextEditingController ageTextEditingController = TextEditingController();
  TextEditingController weightTextEditingController = TextEditingController();
  TextEditingController mealsPerDayTextEditingController = TextEditingController();
  late Cat cat;
  var itemCount = 0.obs;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
    nameTextEditingController.dispose();
    ageTextEditingController.dispose();
    weightTextEditingController.dispose();
    mealsPerDayTextEditingController.dispose();
  }

  addCat(String name, String age, String weight, String mealsPerDay){
    cat = Cat(name: name, age: age, weight: weight, mealsPerDay: mealsPerDay);
    cats.value.add(cat);
    itemCount.value = cats.value.length;
    nameTextEditingController.clear();
    ageTextEditingController.clear();
    weightTextEditingController.clear();
    mealsPerDayTextEditingController.clear();
  }

  removeCat(int index){
    cats.value.removeAt(index);
    itemCount.value = cats.value.length;
  }
}