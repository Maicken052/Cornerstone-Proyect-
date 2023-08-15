import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../components/text_field.dart'; 
import '../components/button.dart'; 
import '../components/request_util.dart';
import '../components/cupertino_dialog.dart'; 
import '../controllers/user_controller.dart';
import '../routes/app_pages.dart';

class SignUp extends StatelessWidget{
  SignUp({Key? key}) : super(key: key);

  //Buscar el controlador de usuario para guardar la info de la persona
  final UserController userController = Get.find<UserController>();
  //Objeto para hacer peticiones http
  final RequestUtil requestUtil = RequestUtil();

  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmpasswordController = TextEditingController();
  
  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                //Logo
                Image.asset(
                  'images/signup_cat.png',
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
                  passwordField: false,
                  prefix: const Icon(Icons.account_circle_outlined),
                ),
                
                const SizedBox(height: 20),
          
                //Caja de texto para el email
                MyTextField(
                  controller: emailController,
                  hintText: 'Email',
                  hide: false,
                  passwordField: false,
                  prefix: const Icon(Icons.email),
                ),
          
                const SizedBox(height: 20),
          
                //Caja de texto para la contraseña
                MyTextField(
                  controller: passwordController,
                  hintText: 'Password',
                  hide: true,
                  passwordField: true,
                  prefix: const Icon(Icons.lock),
                ),
          
                const SizedBox(height: 20),
                
                //Caja de texto para confirmar la ontraseña
                MyTextField(
                  controller: confirmpasswordController,
                  hintText: 'Confirm Password',
                  hide: true,
                  passwordField: true,
                  prefix: const Icon(Icons.lock),
                ),
          
                const SizedBox(height: 30),
          
                //Botón de registrarse
                Button(
                  onTap: () async{
                    try{
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return const Center(
                            child: CircularProgressIndicator(
                              color: Colors.black
                            ),
                          );
                        },
                      );

                      if(passwordController.text == confirmpasswordController.text){
                        if(usernameController.text != ""){

                          //Intenta registrar al usuario en la base de datos
                          http.Response response = await requestUtil.register(usernameController.text, emailController.text, passwordController.text);  

                          if(response.statusCode == 200){
                            userController.setUser(usernameController.text, emailController.text, passwordController.text);  
                            Get.offAndToNamed(AppPages.HOME);  
                            usernameController.clear();
                            emailController.clear();
                            passwordController.clear();
                            confirmpasswordController.clear();
                          }else{
                            Map decodedResponse = json.decode(response.body);
                            if(response.statusCode == 422){  //Error por campos de texto vacios
                              String error = decodedResponse['detail'].elementAt(0)['msg'];
                              if(context.mounted){
                                cupertinoDialog(context, error, 'Error', () => Navigator.pop(context));
                              }
                            }else{  //Errores varios(contraseña corta, email invalido, etc)
                              String error = decodedResponse['detail'];
                              if(context.mounted){
                                cupertinoDialog(context, error, 'Error', () => Navigator.pop(context));
                              }
                            }
                          }
                        }else{ 
                          cupertinoDialog(context, 'Please enter a username', 'Error', () => Navigator.pop(context));
                        }
                      }else{  
                        cupertinoDialog(context, 'The passwords entered do not match', 'Error', () => Navigator.pop(context));
                      }
                    }catch(e){
                      cupertinoDialog(context, e.toString(), 'Error', () => Get.offAndToNamed(AppPages.SIGNUP));
                    }
                  },
                  containerColor: Colors.black,
                  textColor: Colors.white,
                  text: 'Sign Up',
                ),
          
                const SizedBox(height: 20),
          
                //Separador 'or'
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    children: [
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
                Button(
                  onTap: () => Get.offAndToNamed(AppPages.LOGIN),
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


