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

class Login extends StatelessWidget{
  Login({Key? key}) : super(key: key);

  //Usar el controlador de usuario
  final userController = Get.find<UserController>(); 

  //Controlar la info de las casillas de usuario y contraseña
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  //Obejeto para peticiones http
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
                  'images/pet.png',
                  width: 250.0,
                  height: 250.0,
                ),
          
                //Frase de bienvenida
                const Text(
                  "¡Welcome!", 
                  style: TextStyle(
                    fontSize: 40.0,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'JosefinSans',
                    letterSpacing: 1.0,
                    color: Colors.black,
                  )
                ),
                
                const SizedBox(height: 20),
          
                //Caja de texto para el usuario
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
          
                //Olvidaste la contraseña?
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: const [
                      Text(
                        'Forgot Password?',
                        style: TextStyle(
                        fontSize: 16.0,
                        fontFamily: 'JosefinSans',
                        color: Colors.black,
                        )
                      )
                    ]
                  )
                ),
          
                const SizedBox(height: 20),
          
                //Botón de inicar sesión
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

                      //Intenta buscar el email y contraseña en la base de datos
                      http.Response response = await requestUtil.login(emailController.text, passwordController.text);

                      //Si se encuentran registrados 
                      if(response.statusCode == 200){
                        http.Response name = await requestUtil.getName(emailController.text);  //Obtiene el username 
                        var dict = json.decode(name.body);
                        String username = dict['user'];
                        userController.setUser(username, emailController.text, passwordController.text);  //Guarda la info de la persona 
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
                        }else{  //Error por email o contraseña incorrectas
                          var error = dict['detail'];
                          if(context.mounted){
                            cupertinoDialog(context, error, 'Error', () => Navigator.pop(context));
                          }
                        }
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
                  text: 'Log In',
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
                        )
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
                        )
                      ),
                
                      Expanded(
                        child: Divider(
                          thickness: 1,
                          color: Colors.grey,
                        )
                      )
                    ]
                  )
                ),
          
                const SizedBox(height: 20),
          
                //Botón para registrarse
                MyButton(
                  onTap: () => Get.offAllNamed(AppPages.SIGNUP),
                  containerColor: Colors.white,
                  textColor: Colors.black,
                  text: 'Sign Up',
                )
              ]
            )
          )
        )
      )
    );
  }
}

