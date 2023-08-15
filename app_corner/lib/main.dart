import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import '../routes/app_pages.dart';
import 'controllers/user_controller.dart';

Future main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); //Inicializa Firebase
  runApp(const App());
  Get.put(UserController());  //Inicializa el controlador de usuario
}

class App extends StatelessWidget{ 
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