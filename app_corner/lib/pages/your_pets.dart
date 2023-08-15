import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/pets_controller.dart';
import '../controllers/user_controller.dart';
import '../models/cat_model.dart';
import '../routes/app_pages.dart';

class YourPets extends GetView<PetsController>{
  YourPets({Key? key}) : super(key: key);

  //Buscar el controlador de usuario para usar el email de la persona
  final String userEmail = Get.find<UserController>().email.value; 

  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        leading: BackButton(
          onPressed: () => Get.toNamed(AppPages.HOME),
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
        )
      ),

      body: FutureBuilder(
        future: controller.addCats(userEmail),
        builder: (BuildContext context, AsyncSnapshot snapshot){
          if(snapshot.connectionState == ConnectionState.waiting){ 
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.black
              ),
            );
          }else if (snapshot.hasError){  
            return Center(
              child: Text(
                snapshot.error.toString(),
                style: const TextStyle(
                  fontSize: 30.0,
                  fontFamily: 'JosefinSans',
                  color: Colors.black
                )
              ),
            );
          }else if (snapshot.hasData){ 
            return Column(
              children: [
                //Caja con texto de "Your pets:"
                Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 10.0),
                          child: const Text(
                            "Your pets:",
                            style: TextStyle(
                              fontSize: 40.0,
                              fontFamily: 'JosefinSans',
                              fontWeight: FontWeight.w600,
                              color: Colors.black
                            )
                          )
                        ),
                      )
                    ),
                  ]
                ),
                    
                const SizedBox(height: 10.0),
            
                //Si no se han agregado mascotas, se muestra un respectivo mensaje, de lo contrario se muestran las mascotas
                controller.cats.value.isEmpty ?
                  const Text(
                    "no pets added yet",
                    style: TextStyle(
                      fontSize: 20.0,
                      fontFamily: 'JosefinSans',
                      color: Colors.black
                    )
                  ) :
                Expanded(
                  child: Obx(() => ListView.builder(
                    itemCount: controller.cats.value.length,  
                    itemBuilder: (BuildContext context, int index){  
                      final Cat cat = controller.cats.value[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Container(
                          margin: const EdgeInsets.only(bottom: 15.0),
                          child: ListTile(
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
            
                            leading: cat.imageLink != 'no image' ? 
                              CircleAvatar( 
                                radius: 30.0,
                                backgroundColor: Colors.grey[200],
                                child: CircleAvatar(
                                  radius: 26.0,
                                  backgroundImage: NetworkImage(cat.imageLink),
                                  backgroundColor: Colors.white
                                )
                              ) :
                              CircleAvatar( 
                                radius: 30.0,
                                backgroundColor: Colors.grey[200],
                                child: const CircleAvatar(
                                  radius: 26.0,
                                  backgroundImage: AssetImage('images/default_cat.jpg'),
                                  backgroundColor: Colors.white
                                )
                              ),
                            
                            //Amplitud interna de la caja
                            contentPadding: const EdgeInsets.all(15.0),
            
                            tileColor: Colors.grey[350],
            
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0)
                            ),
            
                            onTap: () => Get.toNamed(AppPages.PET, arguments: cat),
                          ),
                        )
                      );
                    })
                  )
                )
              ]
            );
          }else{  
            return const Center(
              child: Text(
                'Something went wrong',
                style: TextStyle(
                  fontSize: 30.0,
                  fontFamily: 'JosefinSans',
                  color: Colors.black
                )
              ),
            );
          }
        }
      )
    );
  }
}
