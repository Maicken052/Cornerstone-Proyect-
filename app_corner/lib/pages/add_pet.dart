import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../components/image_picker.dart';
import '../components/text_field.dart'; 
import '../components/button.dart'; 
import '../components/request_util.dart'; 
import '../controllers/user_controller.dart';
import '../components/cupertino_dialog.dart'; 
import '../components/firebase_util.dart'; 
import '../routes/app_pages.dart';

class AddPet extends StatefulWidget {
  const AddPet({Key? key}): super(key: key);

  @override
  State<AddPet> createState() => _AddPetState();
}

class _AddPetState extends State<AddPet> {

  //Objeto para hacer las peticiones
  final RequestUtil requestUtil = RequestUtil();
  //Buscar el controlador de usuario para usar el email de la persona
  final String userEmail = Get.find<UserController>().email.value;
  //imagen del gato
  final Rx<Uint8List> catPicture = Rx<Uint8List>(Uint8List(0));

  final TextEditingController nameController = TextEditingController();
  final TextEditingController birthdateController = TextEditingController();
  final TextEditingController weightController = TextEditingController();

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
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
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
              Obx((){
                return Stack(
                  children: [
                    catPicture.value.lengthInBytes != 0 ?
                    CircleAvatar( 
                      radius: 90.0,
                      backgroundImage: MemoryImage(catPicture.value)
                    ) :
                    const CircleAvatar( 
                      backgroundImage: AssetImage(
                        "images/default_cat.jpg",  
                      ),
                      radius: 90.0,
                    ),

                    Positioned(
                      bottom: -10,
                      left: 120,
                      child: IconButton(
                        onPressed: () async{
                          Uint8List img = await pickImage();
                          img.lengthInBytes != 0 ?
                          catPicture.value = img :
                          null;
                        },
                        icon: const Icon(Icons.add_a_photo),
                        iconSize: 30.0, 
                      )
                    )
                  ],
                );
              }),
        
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
                controller: nameController,
                hintText: 'Name', 
                hide: false,
                passwordField: false,
                prefix: const Icon(Icons.pets_outlined),
              ),
              
              const SizedBox(height: 20),

              //Campos de texto para añadir la fecha de nacimiento
              MyTextField(
                controller: birthdateController, 
                hintText: 'Birthdate (YYYY-MM-DD)', 
                hide: false,
                passwordField: false,
                prefix: const Icon(Icons.cake_outlined),
              ),
        
              const SizedBox(height: 20),

              //Campos de texto para añadir el peso
              MyTextField(
                controller: weightController, 
                hintText: 'Weight (in Kg)', 
                hide: false,
                passwordField: false,
                prefix: const Icon(Icons.monitor_weight_outlined),
              ),
        
              const SizedBox(height: 20),
              
              //Botón para añadir el gato
              Button(
                onTap: () async{
                  try{
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return const Center(
                          child: CircularProgressIndicator(
                            color: Colors.black
                          )
                        );
                      }
                    );
                    if(nameController.text != ""){
                      //Si el peso es un número y es mayor a 0
                      if(int.tryParse(weightController.text) != null && int.parse(weightController.text) > 0){
                        RegExp regex = RegExp(r'^\d{4}-\d{2}-\d{2}$'); //Expresión para validar si la fecha de nacimiento está en el formato correcto	
                        if(regex.hasMatch(birthdateController.text)){
                          DateTime enteredDate = DateTime.parse(birthdateController.text);
                          DateTime currentDate = DateTime.now();
                          int year = enteredDate.year;
                          int month = enteredDate.month;
                          int day = enteredDate.day;
                          int maxDayInMonth = DateTime(year, month, 0).day;
                          
                          //Si la fecha de nacimiento es anterior a la fecha actual y el mes y día están en el rango correcto
                          if(enteredDate.isBefore(currentDate) && (month >= 1 && month <= 12) && (day >= 1 && day <= maxDayInMonth) && (year >= currentDate.year - 27 )){
                            String responseOfUpload = '';
                            catPicture.value.lengthInBytes != 0 ?
                            responseOfUpload = await FirebaseUtil().saveData(userEmail, 'pets', nameController.text, catPicture.value) :
                            responseOfUpload = 'success'; //si no se sube una foto, se considera que la petición fue exitosa y se asigna posteriormente la foto default
                            if (responseOfUpload == 'success'){

                              //Petición para agregar al gato
                              http.Response response = await requestUtil.addCat(nameController.text, birthdateController.text, weightController.text, userEmail);

                              if(response.statusCode == 201){
                                //Si el peso es mayor a 20
                                if(int.parse(weightController.text) > 20){
                                  if(context.mounted){
                                    cupertinoDialog(context, 'Pet added successfully, but the weight is anormal, go to a veterinary', '¡Congratulations!', () => Get.offAndToNamed(AppPages.HOME));
                                  }
                                }else{
                                  if(context.mounted){
                                  cupertinoDialog(context, 'Pet added successfully', '¡Congratulations!', () => Get.offAndToNamed(AppPages.HOME));
                                  }
                                }
                                nameController.clear();
                                birthdateController.clear();
                                weightController.clear();
                              }else{
                                await FirebaseUtil().deleteCatPicture(userEmail, 'pets', nameController.text); //Borrar las fotos y el documento de firestore y storage dado que no se subió correctamente el gato	
                                Map decodedResponse = json.decode(response.body);
                                if(response.statusCode == 422){  
                                  String error = decodedResponse['detail'].elementAt(0)['msg'];
                                  if(context.mounted){
                                    cupertinoDialog(context, error, 'Error', () => Navigator.pop(context));
                                  }
                                }else{  
                                  String error = decodedResponse['detail'];
                                  if(context.mounted){
                                    cupertinoDialog(context, error, 'Error', () => Navigator.pop(context));
                                  }
                                }
                              }
                            }else{
                              if(context.mounted){
                                cupertinoDialog(context, responseOfUpload, 'Error', () => Navigator.pop(context));
                              }
                            }
                          }else{
                            cupertinoDialog(context, 'Birthdate must be a valid date', 'Error', () => Navigator.pop(context));
                          }
                        }else{
                          cupertinoDialog(context, 'Birthdate must be in the valid format YYYY-MM-DD', 'Error', () => Navigator.pop(context));
                        }
                      }else{
                        cupertinoDialog(context, 'Weight must be a valid number', 'Error', () => Navigator.pop(context));
                      }
                    }else{
                      cupertinoDialog(context, 'Add all the required cat info', 'Error', () => Navigator.pop(context));
                    }
                  }catch(e){
                    cupertinoDialog(context, e.toString(), 'Error', () => Get.offAndToNamed(AppPages.HOME));
                  }
                },
                containerColor: const Color.fromARGB(255, 27, 27, 27),
                textColor: Colors.white, 
                text: 'Add'
              ),
            ]
          )
        ),
      )
    );
  }
}