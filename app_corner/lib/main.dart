import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:app_corner/routes/app_pages.dart';
import 'package:app_corner/components/user_controller.dart';

//Función que ejecuta la aplicación
void main(){
  runApp(const App());
  Get.put(UserController());  //Inicializa el controlador de usuario
} 

class App extends StatelessWidget { 
const App({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context){ 
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,  //Quitar el banner de debug
      title: 'PetFeed',
      initialRoute: AppPages.LOGIN,
      getPages: AppPages.routes,
      theme: ThemeData(
        appBarTheme: const AppBarTheme(  
          color: Colors.transparent,
          elevation: 0,
        ),
      ),
    );
  }
}


