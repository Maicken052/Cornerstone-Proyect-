import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:app_corner/routes/app_pages.dart';
import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:app_corner/Components/shared_preferences.dart' as shared_preferences; 
import '../components/request_util.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late String User;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: shared_preferences.getUsername(),
      builder: (context, AsyncSnapshot<String> snapshot) {
        if(snapshot.hasData){
          User = snapshot.data!;
          return Scaffold(
            backgroundColor: Colors.grey[100],
            appBar: AppBar(
              automaticallyImplyLeading: false,
              title: Align(
                alignment: Alignment.centerRight,
                child: Stack(
                  children: [
                    Text(  //Texto de bienvenida
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
                      ),
                    ),
        
                    Text(  //Texto de bienvenida
                      "PetFeed", 
                      style: TextStyle(
                        fontSize: 40.0,
                        fontFamily: 'LilitaOne',
                        letterSpacing: 1.0,
                        color: Colors.grey[100],
                      ),
                    ),
                  ]
                ),
              ),
            ),
        
            body: Column( //Columna principal
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
        
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: Row(  //Row para colocar el container de la bienvenida 
                    children: [
                      Expanded(
                        child: Container(  //Rectangulo azul
                          decoration: BoxDecoration(
                            color: Colors.grey[350],
                            borderRadius: BorderRadius.circular(10),  
                          ),
                          child: Column(  //Columna con la foto y el texto 
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const SizedBox(height: 10.0), 
                              const CircleAvatar(  //Foto de bienvenida
                                backgroundImage: AssetImage(
                                  "images/profile.jpg",  //TODO: Hacer que esto se pueda cambiar a gusto
                                ),
                                radius: 90.0,
                              ),
                              
                              const SizedBox(height: 15.0),  
        
                              Text(  //Texto de bienvenida
                                "¡Hello, $User!",  //TODO: Hacer que esto cambie según el dueño
                                style: const TextStyle(
                                  fontSize: 30.0,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'JosefinSans',
                                  letterSpacing: 1.0,
                                  color: Color.fromARGB(255, 0, 0, 0),
                                )
                              ),
                            ]
                          )
                        ),
                      ),
                    ]
                  ),
                ),
              
                const SizedBox(height: 30), 
        
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
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
                    ElevatedButton(
                      onPressed: () { 
                        Get.toNamed(AppPages.YOUR_PETS);
                      },  
                      style: ElevatedButton.styleFrom(
                        elevation: 20.0,
                        backgroundColor: Color.fromARGB(255, 209, 209, 209),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20), 
                        ),
                      ),
                      child: Image.asset(
                        'images/your_pets.png',
                        width: 140.0,
                        height: 160.0,
                      ),
                    ),
                  ],
                ),
        
                SizedBox(height: 30.0), 
        
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
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
                    ElevatedButton(
                      onPressed: () { 
                        Get.toNamed(AppPages.ADD_PET);
                      },  
                      style: ElevatedButton.styleFrom(
                        elevation: 20.0,
                        backgroundColor: Color.fromARGB(255, 209, 209, 209),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20), 
                        ),
                      ),
                      child: Image.asset(
                        'images/add_pet.png',
                        width: 140.0,
                        height: 160.0,
                      ),
                    ),
                  ],
                ),
              ]
            )
          );
        }else if(snapshot.hasError){
          return Text('${snapshot.error}');
        }else{
          return const CircularProgressIndicator(
            color: Colors.black
          );
        }
      },
    );
  }
}