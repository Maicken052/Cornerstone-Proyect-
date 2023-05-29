import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/cat_model.dart'; 
import '../components/request_util.dart'; 
import 'dart:developer';

class PetsController extends GetxController {

  //objeto para petición http
  final requestUtil = RequestUtil();

  //Lista de gatos de la clase cat
  Rx<List<Cat>> cats = Rx<List<Cat>>([]);

  //Controladores de texto para los campos de texto
  TextEditingController nameTextEditingController = TextEditingController();
  TextEditingController birthdateTextEditingController = TextEditingController();
  TextEditingController weightTextEditingController = TextEditingController();

  //Objeto de la clase Cat
  late Cat cat;

  //Variable para contar el número de gatos
  var itemCount = 0.obs;

  @override
  void onClose() {
    super.onClose();
    nameTextEditingController.dispose();
    birthdateTextEditingController.dispose();
    weightTextEditingController.dispose();
  }

  addCat(String name, String age, String weight, String mealsPerDay){
    cat = Cat(name: name, age: age, weight: weight, mealsPerDay: mealsPerDay);
    cats.value.add(cat);
    itemCount.value = cats.value.length;
    nameTextEditingController.clear();
    birthdateTextEditingController.clear();
    weightTextEditingController.clear();
  }

  addCats(String email) async{
    //Primero se borra la lista para evitar duplicados
    cats.value.clear();

    //Se hace la petición al servidor para obtener las mascotas
    http.Response response = await requestUtil.getPets(email);

    //Si la petición fue exitosa
    if(response.statusCode == 202){
      var data = json.decode(response.body);
      for(var cat in data){  //Se recorre la lista de gatos
        DateTime now = DateTime.now();
        DateTime birthdate = DateTime.parse(cat['birthdate']);
        //Se calcula la edad del gato
        int age = now.year - birthdate.year;
        // Verificar si aún no se ha alcanzado el cumpleaños de este año
        if (birthdate.month > now.month || (birthdate.month == now.month && birthdate.day > now.day)) {
          age--;
        }
        addCat(cat['name'] ?? "no name", age.toString(), cat['weight'].toString(), '0');
      }
      return 'success';
    //Sino, se retorna null para forzar el snapshot.hasError
    }else{
      return null;
    }
  }
}