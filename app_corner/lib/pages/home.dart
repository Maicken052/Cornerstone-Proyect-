import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:developer';
import '../components/user_controller.dart';
import '../routes/app_pages.dart';

class Home extends StatelessWidget{
  Home({Key? key}) : super(key: key);

  // Usar el controlador de usuario
  final userController = Get.find<UserController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        automaticallyImplyLeading: false,
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
              )

            ]
          )
        )
      ),
  
      body: Center(
        child: Column( 
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            
            //Container de bienvenida al usuario
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Row(  
                children: [
                  Expanded(
                    child: Container(  
                      decoration: BoxDecoration(
                        color: Colors.grey[350],
                        borderRadius: BorderRadius.circular(10),  
                      ),
                      child: Column( 
                        children: [
                          const SizedBox(height: 10.0), 

                          //Imagen de mascota
                          const CircleAvatar(  
                            backgroundImage: AssetImage(
                              "images/profile.jpg",  //TODO: Hacer que esto se pueda cambiar a gusto
                            ),
                            radius: 90.0,
                          ),
                          
                          const SizedBox(height: 15.0),  

                          //Texto de bienvenida
                          Text(  
                            "¡Hello, ${userController.getUser()['username']}!",
                            style: const TextStyle(
                              fontSize: 30.0,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'JosefinSans',
                              letterSpacing: 1.0,
                              color: Color.fromARGB(255, 0, 0, 0),
                            )
                          )

                        ]
                      )
                    )
                  )
                ]
              )
            ),
          
            const SizedBox(height: 30), 

            //Botones de ver mascotas
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [

                //Texto de "Your pets"
                const Text(
                  "Your pets:",
                  style: TextStyle(
                    fontSize: 20.0,
                    fontFamily: 'JosefinSans',
                    fontWeight: FontWeight.w600,
                    letterSpacing: 1.0,
                    color: Colors.black,
                  )
                ),

                //Botón de "Your pets"
                ElevatedButton(
                  onPressed: () => Get.offNamed(AppPages.YOUR_PETS),
                  style: ElevatedButton.styleFrom(
                    elevation: 20.0,
                    backgroundColor: Color.fromARGB(255, 209, 209, 209),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20), 
                    )
                  ),
                  child: Image.asset(
                    'images/your_pets.png',
                    width: 140.0,
                    height: 160.0,
                  )
                )

              ]
            ),
        
            SizedBox(height: 30.0), 

            //Texto de "Add pet"
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [

                //Texto de "Add pet"
                const Text(
                  "Add pet:",
                  style: TextStyle(
                    fontSize: 20.0,
                    fontFamily: 'JosefinSans',
                    fontWeight: FontWeight.w600,
                    letterSpacing: 1.0,
                    color: Colors.black,
                  )
                ),

                //Botón de "Add pet"
                ElevatedButton(
                  onPressed: () => Get.toNamed(AppPages.ADD_PET),
                  style: ElevatedButton.styleFrom(
                    elevation: 20.0,
                    backgroundColor: Color.fromARGB(255, 209, 209, 209),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20), 
                    )
                  ),
                  child: Image.asset(
                    'images/add_pet.png',
                    width: 140.0,
                    height: 160.0,
                  )
                )

              ]
            )

          ]
        )
      )
    );
  }
}