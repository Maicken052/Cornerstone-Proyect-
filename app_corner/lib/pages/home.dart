import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/user_controller.dart';
import '../routes/app_pages.dart';
import '../components/drawer.dart';

class Home extends StatelessWidget{
  Home({Key? key}) : super(key: key);

  //Buscar el controlador de usuario para usar el nombre de la persona
  final String username = Get.find<UserController>().username.value; 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.black
        ),
        title: Align(
          alignment: Alignment.centerRight,
          child: Stack(  //se usa stack para poder poner el texto con borde usando dos textos y sobreponiendolos
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

      drawer: const Sidebar(),

      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
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
                                backgroundColor: Colors.white,
                                backgroundImage: AssetImage(
                                  "images/default_cat.jpg", 
                                ),
                                radius: 90.0,
                              ),
                              
                              const SizedBox(height: 15.0),  
        
                              //Texto de bienvenida
                              Text(  
                                "¡Hello, $username!",
                                style: const TextStyle(
                                  fontSize: 30.0,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'JosefinSans',
                                  letterSpacing: 1.0,
                                  color: Color.fromARGB(255, 0, 0, 0),
                                )
                              ),

                              const SizedBox(height: 8.0)
                            ]
                          )
                        )
                      )
                    ]
                  )
                ),
              
                const SizedBox(height: 30), 
        
                //Botón de ver mascotas
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

                    const SizedBox(height: 5.0),  

                    //Botón de "Your pets"
                    ElevatedButton(
                      onPressed: () => Get.toNamed(AppPages.YOUR_PETS),
                      style: ElevatedButton.styleFrom(
                        elevation: 15.0,
                        backgroundColor: Colors.grey[350],
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
            
                const SizedBox(height: 30.0), 
        
                //Botón de agregar mascota
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

                    const SizedBox(height: 5.0), 

                    //Botón de "Add pet"
                    ElevatedButton(
                      onPressed: () => Get.toNamed(AppPages.ADD_PET),
                      style: ElevatedButton.styleFrom(
                        elevation: 15.0,
                        backgroundColor: Colors.grey[350],
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
          ),
        ),
      )
    );
  }
}