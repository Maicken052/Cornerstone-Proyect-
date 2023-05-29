import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:developer';
import '../components/pets_controller.dart';
import '../components/user_controller.dart';
import '../components/cupertino_dialog.dart'; 
import '../routes/app_pages.dart';

class YourPets extends GetView<PetsController> {
  YourPets({Key? key}) : super(key: key);

  // Usar el controlador de usuario
  final userController = Get.find<UserController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        leading: BackButton(
          onPressed: () => Get.toNamed(AppPages.HOME),
          color: Colors.black
        ),
        title: Align(
          alignment: Alignment.centerRight,
          child: Stack(
            children: [
              Text(  
                "PetFeed", 
                style: TextStyle(
                  fontSize: 40.0,
                  fontFamily: 'LilitaOne',
                  fontWeight: FontWeight.w900,
                  letterSpacing: 1.0,
                  foreground: Paint()..style = 
                  PaintingStyle.stroke
                              ..strokeWidth = 5
                              ..color = Colors.black,
                )
              ),
  
              Text( 
                "PetFeed", 
                style: TextStyle(
                  fontSize: 40.0,
                  fontFamily: 'LilitaOne',
                  letterSpacing: 1.0,
                  color: Colors.grey[100],
                )
              ),

            ]
          )
        )
      ),

      //FutureBuilder para obtener las mascotas del usuario
      body: FutureBuilder(
        future: controller.addCats(userController.getUser()['email']!),
        builder: ((context, snapshot){
          if(snapshot.connectionState == ConnectionState.waiting){  //Si la conexión está esperando
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.black
              ),
            );
          }else if (snapshot.hasError){  //Si la conexión tiene un error
            return cupertinoDialog(context, snapshot.error.toString(), 'Error', () => Get.toNamed(AppPages.HOME));
          }else if (snapshot.hasData){  //Si la conexión obtuvo las mascotas
            return Column(
              children: [
                Row(
                  children: [

                    //Caja con texto de "Your pets:"
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        child: const Text(
                          "Your pets:",
                          style: TextStyle(
                            fontSize: 40.0,
                            fontFamily: 'JosefinSans',
                            fontWeight: FontWeight.w600,
                            letterSpacing: 1.0,
                            color: Colors.black
                          )
                        )
                      )
                    )
                  ]
                ),
          
                const SizedBox(height: 10.0),

                //Lista de mascotas
                Expanded(
                  child: Obx(() => ListView.builder(
                    itemCount: controller.itemCount.value,  //Cantidad de mascotas
                    itemBuilder: ((context, index) {  //Iterar sobre las mascotas para crear sus respectivas cajas
                      final cat = controller.cats.value[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Container(
                          margin: const EdgeInsets.only(bottom: 10.0),  //Separación entre cajas
                          child: ListTile(
                            
                            //Titulo de la caja
                            title: Text(
                              cat.name,
                              style: TextStyle(
                              fontSize: 25.0,
                              fontFamily: 'JosefinSans',
                              fontWeight: FontWeight.w500,
                              letterSpacing: 1.0,
                              color: Colors.grey[800]
                              )
                            ),

                            //Imagen de la mascota
                            leading: const CircleAvatar(  
                              backgroundImage: AssetImage(
                              "images/profile.jpg",  //TODO: Hacer que esto se pueda cambiar a gusto
                              ),
                              radius: 30.0
                            ),
                            
                            //Amplitud interna de la caja
                            contentPadding: const EdgeInsets.all(15.0),

                            //Color de la caja
                            tileColor: Colors.grey[350],

                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0)
                            ),

                            onTap: () => Get.toNamed(AppPages.PET, arguments: cat),

                          ),
                        )
                      );
                    })
                  ))
                )
              ]
            );
          }else{  
            return cupertinoDialog(context, 'No pets found', 'Error', () => Get.toNamed(AppPages.PET));
          }
        })
      )
    );
  }
}
