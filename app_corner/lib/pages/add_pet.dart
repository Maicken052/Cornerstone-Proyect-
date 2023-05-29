import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../components/my_text_field.dart'; 
import '../components/my_button.dart'; 
import '../components/pets_controller.dart'; 
import '../components/request_util.dart'; 
import '../components/user_controller.dart';
import '../components/cupertino_dialog.dart'; 
import '../routes/app_pages.dart';

class AddPet extends GetView<PetsController> {
  AddPet({Key? key}): super(key: key);

  //Objeto para hacer las peticiones
  final requestUtil = RequestUtil();

  // Usar el controlador de usuario
  final userController = Get.find<UserController>();
  
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

      body: SafeArea(
        child: SingleChildScrollView(
          child: Column( 
            mainAxisAlignment: MainAxisAlignment.start,
            children: [

              //Título de "Add pet"
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[350],
                          borderRadius: BorderRadius.circular(20.0)
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
                              color: Colors.black
                            )
                          )
                        )
                      )
                    )
                  )
                ]
              ),
        
              const SizedBox(height: 20),

              //Foto de perfil del gato
              const CircleAvatar( 
                backgroundImage: AssetImage(
                  "images/profile.jpg",  //TODO: Hacer que esto se pueda cambiar a gusto
                ),
                radius: 90.0,
              ),
        
              const SizedBox(height: 15),

              //Texto de añadir foto de mascota
              Text(
                "Add a photo of your pet",
                style: TextStyle(
                  fontSize: 18.0,
                  fontFamily: 'JosefinSans',
                  fontWeight: FontWeight.w100,
                  color: Colors.grey[500]
                )
              ),
        
              const SizedBox(height: 20),

              //Campos de texto para añadir el nombre
              MyTextField(
                controller: controller.nameTextEditingController,
                hintText: 'Name', 
                hide: false
              ),
              
              const SizedBox(height: 20),

              //Campos de texto para añadir la fecha de nacimiento
              MyTextField(
                controller: controller.birthdateTextEditingController, 
                hintText: 'Birthdate (YYYY-MM-DD)', 
                hide: false
              ),
        
              const SizedBox(height: 20),

              //Campos de texto para añadir el peso
              MyTextField(
                controller: controller.weightTextEditingController, 
                hintText: 'Weight (in Kg)', 
                hide: false
              ),
        
              const SizedBox(height: 20),
              
              //Botón para añadir el gato
              MyButton(
                onTap: () async{
                  try{

                      //Animación de carga
                      showDialog(
                        context: context,
                        builder: (context) {
                          return const Center(
                            child: CircularProgressIndicator(
                              color: Colors.black
                            )
                          );
                        }
                      );

                      //Si el campo de nombre no está vacío
                      if(controller.nameTextEditingController.text != ""){
                        //Si el peso es un número y es mayor a 0
                        if(int.tryParse(controller.weightTextEditingController.text) != null && int.parse(controller.weightTextEditingController.text)>0){
                          RegExp regex = RegExp(r'^\d{4}-\d{2}-\d{2}$');
                          //Si la fecha de nacimiento está en el formato correcto
                          if(regex.hasMatch(controller.birthdateTextEditingController.text)){
                            DateTime enteredDate = DateTime.parse(controller.birthdateTextEditingController.text);
                            DateTime currentDate = DateTime.now();
                            int year = enteredDate.year;
                            int month = enteredDate.month;
                            int day = enteredDate.day;
                            int maxDayInMonth = DateTime(year, month, 0).day;
                            //Si la fecha de nacimiento es anterior a la fecha actual y el mes y día están en el rango correcto
                            if(enteredDate.isBefore(currentDate) && (month >= 1 && month <= 12) && (day >= 1 && day <= maxDayInMonth)){
                              //Se intenta añadir al gato
                              http.Response response = await requestUtil.addCat(controller.nameTextEditingController.text, controller.birthdateTextEditingController.text, controller.weightTextEditingController.text,userController.getUser()['email']);

                              //Si se logra añadir al gato
                              if(response.statusCode == 201){
                                if(context.mounted){
                                  Navigator.pop(context);
                                }
                                //Si el peso es mayor a 20
                                if(int.parse(controller.weightTextEditingController.text)>20){
                                  if(context.mounted){
                                    cupertinoDialog(context, 'Pet added successfully, but the weight is anormal, go to a veterinary', '¡Congratulations!', () => Get.offNamed(AppPages.HOME));
                                  }
                                }else{
                                  if(context.mounted){
                                  cupertinoDialog(context, 'Pet added successfully', '¡Congratulations!', () => Get.offNamed(AppPages.HOME));
                                  }
                                }

                              //Mostrar errores
                              }else{
                                if(context.mounted){
                                  Navigator.pop(context);
                                }
                                var dict = json.decode(response.body);

                                if(response.statusCode == 422){  //Error por campos de texto vacios
                                  var error = dict['detail'].elementAt(0)['msg'];
                                  if(context.mounted){
                                    cupertinoDialog(context, error, 'Error', () => Navigator.pop(context));
                                  }
                                }else{  
                                  var error = dict['detail'];
                                  if(context.mounted){
                                    cupertinoDialog(context, error, 'Error', () => Navigator.pop(context));
                                  }
                                }
                              }
                            }else{
                              if(context.mounted){
                                Navigator.pop(context);
                              }
                              cupertinoDialog(context, 'Birthdate must be a valid date', 'Error', () => Navigator.pop(context));
                            }
                          }else{
                            if(context.mounted){
                              Navigator.pop(context);
                            }
                            cupertinoDialog(context, 'Birthdate must be in the valid format YYYY-MM-DD', 'Error', () => Navigator.pop(context));
                          }
                        }else{
                          if(context.mounted){
                            Navigator.pop(context);
                          }
                          cupertinoDialog(context, 'Weight must be a valid number', 'Error', () => Navigator.pop(context));
                        }
                      }else{
                        if(context.mounted){
                          Navigator.pop(context);
                        }
                        cupertinoDialog(context, 'Add all the required cat info', 'Error', () => Navigator.pop(context));
                      }

                    //Errores inesperados
                    }catch(e){
                      if(context.mounted){
                          Navigator.pop(context);
                        }
                      cupertinoDialog(context, 'Unexpected crash, please check your internet connection or open the app again', 'Error', () => Navigator.pop(context));
                    }
                },
                containerColor: const Color.fromARGB(255, 27, 27, 27),
                textColor: Colors.white, 
                text: 'Add'
              )
              
            ]
          )
        ),
      )
    );
  }
}