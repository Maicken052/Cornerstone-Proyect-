import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:developer';
import '../components/my_text_field.dart'; 
import '../components/my_button.dart'; 
import '../components/request_util.dart';
import '../components/cupertino_dialog.dart'; 
import '../components/user_controller.dart';
import '../routes/app_pages.dart';

class SignUp extends StatelessWidget{
  SignUp({Key? key}) : super(key: key);

  //Usar el controlador de usuario
  final userController = Get.find<UserController>();

  //Controlar la info de las casillas de usuario y contraseña
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmpasswordController = TextEditingController();

  //Objeto para hacer peticiones http
  final requestUtil = RequestUtil();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                
                //Logo
                Image.asset(
                  'images/ca_cat.png',
                  width: 400.0,
                  height: 150.0,
                ),
          
                const SizedBox(height: 10),
          
                //Frase de bienvenida
                const Text(
                  "Let's create your account!", 
                  style: TextStyle(
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'JosefinSans',
                    letterSpacing: 1.0,
                    color: Colors.black,
                  )
                ),
                
                const SizedBox(height: 20),
          
                //Caja de texto para el usuario
                MyTextField(
                  controller: usernameController,
                  hintText: 'Username',
                  hide: false,
                ),
                
                const SizedBox(height: 20),
          
                //Caja de texto para el email
                MyTextField(
                  controller: emailController,
                  hintText: 'Email',
                  hide: false,
                ),
          
                const SizedBox(height: 20),
          
                //Caja de texto para la contraseña
                MyTextField(
                  controller: passwordController,
                  hintText: 'Password',
                  hide: true,
                ),
          
                const SizedBox(height: 20),
                
                //Caja de texto para confirmar la ontraseña
                MyTextField(
                  controller: confirmpasswordController,
                  hintText: 'Confirm Password',
                  hide: true,
                ),
          
                const SizedBox(height: 30),
          
                //Botón de registrarse
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
                            ),
                          );
                        },
                      );

                      //Si las contraseñas de ambos campos de texto fueron ingresadas correctamente
                      if(passwordController.text == confirmpasswordController.text){
                        //Si el usuario no es vacio
                        if(usernameController.text != ""){
                          http.Response response = await requestUtil.register(usernameController.text, emailController.text, passwordController.text);  //Intenta registrar al usuario en la base de datos

                          if(response.statusCode == 200){
                            userController.setUser(usernameController.text, emailController.text, passwordController.text);  //Guarda la info de la persona en el celular
                            Get.offAndToNamed(AppPages.HOME);  

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
                            }else{  //Errores varios(contraseña corta, email invalido, etc)
                              var error = dict['detail'];
                              if(context.mounted){
                                cupertinoDialog(context, error, 'Error', () => Navigator.pop(context));
                              }
                            }
                          }
                        }else{  //Error por usuario vacio
                          if(context.mounted){
                            Navigator.pop(context);
                          }
                          cupertinoDialog(context, 'Please enter a username', 'Error', () => Navigator.pop(context));
                        }
                      }else{  //Error por contraseñas no iguales
                        if(context.mounted){
                          Navigator.pop(context);
                        }
                        cupertinoDialog(context, 'The passwords entered do not match', 'Error', () => Navigator.pop(context));
                      }
                      
                    //Errores inesperados
                    }catch(e){
                      if(context.mounted){
                          Navigator.pop(context);
                        }
                      cupertinoDialog(context, 'Unexpected crash, please check your internet connection or open the app again', 'Error', () => Navigator.pop(context));
                    }
                  },
                  containerColor: Colors.black,
                  textColor: Colors.white,
                  text: 'Sign Up',
                ),
          
                const SizedBox(height: 20),
          
                //Separador 'or'
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    children: const [
                      Expanded(
                        child: Divider(
                          thickness: 1,
                          color: Colors.grey,
                        ),
                      ),
                
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.0),
                        child: Text(
                          'or',
                          style: TextStyle(
                          fontSize: 20.0,
                          fontFamily: 'JosefinSans',
                          color: Colors.black,
                          )
                        ),
                      ),
                
                      Expanded(
                        child: Divider(
                          thickness: 1,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
          
                const SizedBox(height: 20),
          
                //Botón de inicar sesión
                MyButton(
                  onTap: () => Get.offAllNamed(AppPages.LOGIN),
                  containerColor: Colors.white,
                  textColor: Colors.black,
                  text: 'Log In',
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}


