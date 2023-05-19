import 'package:flutter/material.dart';
import 'package:app_corner/Components/my_text_field.dart'; 
import 'package:app_corner/Components/my_button.dart'; 
import 'package:app_corner/Components/shared_preferences.dart' as shared_preferences; 
import 'package:get/get.dart';
import 'package:app_corner/routes/app_pages.dart';
import 'package:http/http.dart' as http;
import '../components/request_util.dart';
import 'dart:developer';
import 'dart:convert';
import 'package:flutter/cupertino.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  //Obtener la info de las casillas de ussuario y contraseña
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
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
                      ),
                    ],
                  ),
                ),
          
                const SizedBox(height: 20),
          
                //Botón de inicar sesión
                MyButton(
                  onTap: () async{
                    try{
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

                      http.Response response = await requestUtil.login(emailController.text, passwordController.text);

                      if(response.statusCode == 200){
                        http.Response name = await requestUtil.getName(emailController.text);
                        var dict = json.decode(name.body);
                        String username = dict['user'];
                        shared_preferences.saveUserData(username, emailController.text, passwordController.text);
                        Get.offAllNamed(AppPages.HOME);
                      }else{
                        Navigator.pop(context);
                        var dict = json.decode(response.body);
                        if(response.statusCode == 422){
                          var error = dict['detail'].elementAt(0)['msg'];
                          showCupertinoDialog(
                            context: context,
                            builder: (BuildContext context) => CupertinoAlertDialog(
                              title: const Text(
                                'Error',
                                style: TextStyle(fontSize: 22),
                              ),
                              content: Text(
                                error,
                                style: const TextStyle(fontSize: 16),
                              ),
                              actions: [
                                CupertinoDialogAction(
                                  child: Text('OK'),
                                  textStyle: TextStyle(
                                    color: Colors.black
                                  ),
                                  onPressed: () => Navigator.pop(context),
                                )
                              ]
                            )
                          );
                        }else{
                          var error = dict['detail'];
                          showCupertinoDialog(
                            context: context,
                            builder: (BuildContext context) => CupertinoAlertDialog(
                              title: const Text(
                                'Error',
                                style: TextStyle(fontSize: 22),
                              ),
                              content: Text(
                                error,
                                style: const TextStyle(fontSize: 16),
                              ),
                              actions: [
                                CupertinoDialogAction(
                                  child: Text('OK'),
                                  textStyle: TextStyle(
                                    color: Colors.black
                                  ),
                                  onPressed: () => Navigator.pop(context),
                                )
                              ]
                            )
                          );
                        }
                      }
                    }catch(e){
                      Get.offAllNamed(AppPages.LOGIN);
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
          
                //Botón para registrarse
                MyButton(
                  onTap: () {
                    Get.offAllNamed(AppPages.SIGNUP);
                  },
                  containerColor: Colors.white,
                  textColor: Colors.black,
                  text: 'Sign Up',
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

