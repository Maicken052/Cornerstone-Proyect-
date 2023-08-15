import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/cat_model.dart'; 
import '../components/request_util.dart'; 
import '../components/firebase_util.dart';

class PetsController extends GetxController {
  //objeto para petición http
  final RequestUtil requestUtil = RequestUtil();
  //Lista de gatos de la clase cat
  Rx<List<Cat>> cats = Rx<List<Cat>>([]);

  void addCat(String name, String age, String weight, String mealsPerDay, String imageLink){
    Cat cat = Cat(name: name, age: age, weight: weight, mealsPerDay: mealsPerDay, imageLink: imageLink);
    cats.value.add(cat);
  }

  Future addCats(String email) async{
    DateTime now = DateTime.now();
    String imageLink = '';
    String catName = '';
    int mealsPerDay = 0;

    //Se borra la lista para evitar duplicados
    cats.value.clear();
    //Se hace la petición al servidor para obtener las mascotas
    http.Response response = await requestUtil.getPets(email);

    if(response.statusCode == 202){
      List decodedResponse = json.decode(response.body);
      for(Map cat in decodedResponse){  
        //Se calcula la edad del gato
        DateTime birthdate = DateTime.parse(cat['birthdate']);
        int age = now.year - birthdate.year;
        // Verificar si aún no se ha alcanzado el cumpleaños de este año
        if (birthdate.month > now.month || (birthdate.month == now.month && birthdate.day > now.day)){
          age--;
        }
        //Se calcula el número de comidas por día
        age == 0 ?
          mealsPerDay = 4 :
          mealsPerDay = 2;
        //se agrega la foto del gato y se agrega a la lista
        try{
          cat['name'] == '' || cat['name'] == null ? catName = 'no name' : catName = cat['name'];
          imageLink = await FirebaseUtil().getImageLink(email, 'pets', catName);
          addCat(catName, age.toString(), cat['weight'].toString(), mealsPerDay.toString(), imageLink);
        }catch(e){
          return null;
        }
      }
      return 'success';
    }else{
      return null;
    }
  }
}