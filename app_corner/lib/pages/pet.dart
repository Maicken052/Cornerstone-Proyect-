import 'package:flutter/material.dart'; 
import 'package:get/get.dart';
import '../components/button.dart'; 
import '../models/cat_model.dart'; 

class Pet extends StatefulWidget{
  const Pet({super.key});

  @override
  State<Pet> createState() => _PetState();
}

class _PetState extends State<Pet>{
  final Cat cat = Get.arguments;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        leading: const BackButton(
          color: Colors.black
        ),
        title: Align(
          alignment: Alignment.centerRight,
          child: Stack( //se usa stack para poder poner el texto con borde usando dos textos y sobreponiendolos
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
        ),
      ),
  
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                
                //Contenedor con la foto y el nombre del gato
                Row(  
                  children: [
                    Expanded(
                      child: Container(  
                        decoration: BoxDecoration(
                          color: Colors.grey[350],
                          borderRadius: BorderRadius.circular(10),  
                        ),
                        child: Column(   
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const SizedBox(height: 10.0),

                            //Foto del gato
                            cat.imageLink != 'no image' ? 
                              CircleAvatar( 
                                radius: 84.0,
                                backgroundColor: Colors.grey[200],
                                child: CircleAvatar(
                                  radius: 80.0,
                                  backgroundImage: NetworkImage(cat.imageLink),
                                  backgroundColor: Colors.white
                                )
                              ) :
                              CircleAvatar( 
                                radius: 84.0,
                                backgroundColor: Colors.grey[200],
                                child: const CircleAvatar(
                                  radius: 80.0,
                                  backgroundImage: AssetImage('images/default_cat.jpg'),
                                  backgroundColor: Colors.white
                                )
                              ),

                            const SizedBox(height: 10.0),  
                            
                            //Nombre del gato
                            Text(  
                              cat.name, 
                              style: const TextStyle(
                                fontSize: 30.0,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'JosefinSans',
                                color: Colors.black87
                              )
                            ),
                            
                            const SizedBox(height: 5.0)
                          ]
                        )
                      )
                    )
                  ]
                ),
          
                const SizedBox(height: 20.0),
        
                //Edad del gato
                Text(
                  'Age',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'JosefinSans',
                    letterSpacing: 1.0,
                    color: Colors.grey[500]
                  )
                ),
          
                const SizedBox(height: 10.0),
          
                Text(
                  '${cat.age} Years',
                  style: const TextStyle(
                    fontSize: 20.0,
                    fontFamily: 'JosefinSans',
                    color: Colors.black
                  )
                ),
          
                const Row(
                  children: [
                    Expanded(
                      child: Divider(
                        thickness: 2,
                        color: Colors.grey
                      )
                    )
                  ]
                ),
          
                const SizedBox(height: 20.0),
        
                //Peso del gato
                Text(
                  'Weight',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'JosefinSans',
                    letterSpacing: 1.0,
                    color: Colors.grey[500]
                  )
                ),
                
                const SizedBox(height: 10.0),
          
                Text(
                  '${cat.weight} Kg',
                  style: const TextStyle(
                    fontSize: 20.0,
                    fontFamily: 'JosefinSans',
                    color: Colors.black
                  )
                ),
          
                const Row(
                  children: [
                    Expanded(
                      child: Divider(
                        thickness: 2,
                        color: Colors.grey
                      )
                    )
                  ]
                ),
          
                const SizedBox(height: 20.0),
        
                //Comidas por día del gato
                Text(
                  'Meals Per Day',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'JosefinSans',
                    letterSpacing: 1.0,
                    color: Colors.grey[500]
                  )
                ),
          
                const SizedBox(height: 10.0),
          
                Text(
                  cat.mealsPerDay,
                  style: const TextStyle(
                    fontSize: 20.0,
                    fontFamily: 'JosefinSans',
                    color: Colors.black
                  )
                ),
          
                const Row(
                  children: [
                    Expanded(
                      child: Divider(
                        thickness: 2,
                        color: Colors.grey
                      )
                    )
                  ]
                ),
        
                const SizedBox(height: 20.0),
        
                //Agua bebida por el gato
                Text(
                  'Drinked Water Today',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'JosefinSans',
                    letterSpacing: 1.0,
                    color: Colors.grey[500]
                  )
                ),
          
                const SizedBox(height: 10.0),
          
                const Text(
                  '0',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontFamily: 'JosefinSans',
                    color: Colors.black
                  )
                ),
        
                const Row(
                  children: [
                    Expanded(
                      child: Divider(
                        thickness: 2,
                        color: Colors.grey
                      )
                    )
                  ]
                ),
        
                const SizedBox(height: 15.0),
                
                //Botón para girar el plato
                Button(
                  onTap: (){
                    
                  },
                  containerColor: Colors.white,
                  textColor: Colors.black,
                  text: 'Connect'
                )
              ]
            )
          ),
        ),
      )
    );
  }
}