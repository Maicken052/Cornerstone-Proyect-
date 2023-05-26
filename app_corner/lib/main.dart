import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:app_corner/routes/app_pages.dart';

//Función que ejecuta la aplicación
void main() => runApp(App());

class App extends StatelessWidget { 
const App({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context){ 
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
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


