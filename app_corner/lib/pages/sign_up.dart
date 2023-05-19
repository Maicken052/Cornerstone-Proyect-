import 'package:flutter/material.dart';
import 'package:app_corner/Components/my_text_field.dart'; 
import 'package:app_corner/Components/my_button.dart'; 
import 'package:get/get.dart';
import 'package:app_corner/routes/app_pages.dart';
import 'package:http/http.dart' as http;
import 'package:app_corner/Components/shared_preferences.dart' as shared_preferences; 
import '../components/request_util.dart';
import 'dart:developer';
import 'dart:convert';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {

  //Obtener la info de las casillas de usuario y contraseña
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmpasswordController = TextEditingController();
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

                    if(passwordController.text == confirmpasswordController.text){
                      http.Response response = await requestUtil.register(usernameController.text, emailController.text, passwordController.text);
                      if(response.statusCode == 200){
                        shared_preferences.saveUserData(usernameController.text, emailController.text, passwordController.text);
                        Get.offAllNamed(AppPages.HOME);
                      }else{
                        log(response.statusCode.toString());
                      }
                    }else{
                      log('passwords doesnt match');
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
                  onTap: () {
                    Get.offAllNamed(AppPages.LOGIN);
                  },
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


