import 'package:flutter/material.dart'; 
import 'package:get/get.dart';
import 'package:app_corner/routes/app_pages.dart';
import 'package:app_corner/Models/cat_model.dart'; 
import 'package:app_corner/Components/my_button.dart'; 

class Pet extends StatefulWidget {
  const Pet({super.key});

  @override
  State<Pet> createState() => _PetState();
}

class _PetState extends State<Pet> {
  @override
  Widget build(BuildContext context) {
    Cat cat = Get.arguments;

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        leading: const BackButton(
          color: Colors.black
        ),
        title: Align(
          alignment: Alignment.centerRight,
          child: Stack(children: [
            Text(
              //Texto de bienvenida
              "PetFeed",
              style: TextStyle(
                fontSize: 40.0,
                fontFamily: 'LilitaOne',
                fontWeight: FontWeight.w900,
                letterSpacing: 1.0,
                foreground: Paint()
                  ..style = PaintingStyle.stroke
                  ..strokeWidth = 5
                  ..color = Colors.black,
              ),
            ),
            Text(
              //Texto de bienvenida
              "PetFeed",
              style: TextStyle(
                fontSize: 40.0,
                fontFamily: 'LilitaOne',
                letterSpacing: 1.0,
                color: Colors.grey[100],
              ),
            ),
          ]),
        ),
      ),
  
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: Column( //Columna principal
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
      
            Row(  //Row para colocar el container de la bienvenida 
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
                        SizedBox(height: 10.0),
                        CircleAvatar(  //Foto de bienvenida
                          backgroundImage: AssetImage(
                            "images/profile.jpg",  //TODO: Hacer que esto se pueda cambiar a gusto
                          ),
                          radius: 80.0,
                        ),
                        
                        SizedBox(height: 15.0),  
      
                        Text(  //Texto de bienvenida
                          cat.name, 
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
      
            const SizedBox(height: 20.0),
      
            Text(
              'Age',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                fontFamily: 'JosefinSans',
                letterSpacing: 1.0,
                color: Colors.grey[500],
              )
            ),
      
            const SizedBox(height: 10.0),
      
            Text(
              '${cat.age} Years',
              style: const TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                fontFamily: 'JosefinSans',
                letterSpacing: 1.0,
                color: Color.fromARGB(255, 0, 0, 0),
              )
            ),
      
            Row(
              children: const[
                Expanded(
                  child: Divider(
                    thickness: 2,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
      
            const SizedBox(height: 20.0),
      
            Text(
              'Weight',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                fontFamily: 'JosefinSans',
                letterSpacing: 1.0,
                color: Colors.grey[500],
              )
            ),
            
            const SizedBox(height: 10.0),
      
            Text(
              '${cat.weight} Kg',
              style: const TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                fontFamily: 'JosefinSans',
                letterSpacing: 1.0,
                color: Color.fromARGB(255, 0, 0, 0),
              )
            ),
      
            Row(
              children: const[
                Expanded(
                  child: Divider(
                    thickness: 2,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
      
            const SizedBox(height: 20.0),
      
            Text(
              'Meals Per Day',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                fontFamily: 'JosefinSans',
                letterSpacing: 1.0,
                color: Colors.grey[500],
              )
            ),
      
            const SizedBox(height: 10.0),
      
            Text(
              cat.mealsPerDay,
              style: const TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                fontFamily: 'JosefinSans',
                letterSpacing: 1.0,
                color: Color.fromARGB(255, 0, 0, 0),
              )
            ),
      
            Row(
              children: const[
                Expanded(
                  child: Divider(
                    thickness: 2,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20.0),
      
            Text(
              'Drinked Water Today',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                fontFamily: 'JosefinSans',
                letterSpacing: 1.0,
                color: Colors.grey[500],
              )
            ),
      
            const SizedBox(height: 10.0),
      
            const Text(
              '0',
              style: 
              
              
              TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                fontFamily: 'JosefinSans',
                letterSpacing: 1.0,
                color: Color.fromARGB(255, 0, 0, 0),
              )
            ),

            Row(
              children: const[
                Expanded(
                  child: Divider(
                    thickness: 2,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 15.0),
            
            MyButton(
              onTap: (){

              },
              containerColor: Colors.white,
              textColor: Colors.black,
              text: 'Spin',
            )
          ]
        ),
      )
    );
  }
}