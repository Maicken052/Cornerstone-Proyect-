import 'package:flutter/material.dart';
import 'package:app_corner/Components/my_text_field.dart'; 
import 'package:app_corner/Components/my_button.dart'; 
import 'package:app_corner/Components/pets_controller.dart'; 
import 'package:get/get.dart';
import 'package:app_corner/routes/app_pages.dart';


class AddPet extends GetView<PetsController> {
  const AddPet({Key? key}): super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        leading: const BackButton(
          color: Colors.black
        ),
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

      body: SafeArea(
        child: SingleChildScrollView(
          child: Column( //Columna principal
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[350],
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        child: const Center(
                          child: Text(
                            "Add pet:",
                            style: TextStyle(
                              fontSize: 30.0,
                              fontFamily: 'JosefinSans',
                              fontWeight: FontWeight.w600,
                              letterSpacing: 1.0,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
        
              const SizedBox(height: 20),
        
              const CircleAvatar( 
                backgroundImage: AssetImage(
                  "images/profile.jpg",  //TODO: Hacer que esto se pueda cambiar a gusto
                ),
                radius: 90.0,
              ),
        
              const SizedBox(height: 15),
        
              Text(
                "Add a photo of your pet",
                style: TextStyle(
                  fontSize: 18.0,
                  fontFamily: 'JosefinSans',
                  fontWeight: FontWeight.w100,
                  color: Colors.grey[500],
                ),
              ),
        
              const SizedBox(height: 20),
        
              MyTextField(
                controller: controller.nameTextEditingController,
                hintText: 'Name', 
                hide: false
              ),
              

              const SizedBox(height: 20),
        
              MyTextField(
                controller: controller.ageTextEditingController, 
                hintText: 'Age', 
                hide: false
              ),
        
              const SizedBox(height: 20),
        
              MyTextField(
                controller: controller.weightTextEditingController, 
                hintText: 'Weight (in Kg)', 
                hide: false
              ),
        
              const SizedBox(height: 20),
        
              MyTextField(
                controller: controller.mealsPerDayTextEditingController,
                hintText: 'Meals per day', 
                hide: false
              ),
        
              const SizedBox(height: 30),
              
              MyButton(
                onTap: () {
                  controller.addCat(controller.nameTextEditingController.text, controller.ageTextEditingController.text, controller.weightTextEditingController.text, controller.mealsPerDayTextEditingController.text);
                  Get.toNamed(AppPages.YOUR_PETS);
                }, 
                containerColor: const Color.fromARGB(255, 27, 27, 27), 
                textColor: Colors.white, 
                text: 'Add'
              ),
            ],
          ),
        ),
      ),
    );
  }
}