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

class Login extends StatelessWidget{
  Login({Key? key}) : super(key: key);

  //Buscar el controlador de usuario para guardar la info de la persona
  final UserController userController = Get.find<UserController>(); 
  //Objeto para realizar peticiones http
  final RequestUtil requestUtil = RequestUtil();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

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
                  'images/logo.png',
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
          
                //Olvidaste la contraseña?
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 40.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
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

                      //Petición para iniciar sesión
                      http.Response response = await requestUtil.login(emailController.text, passwordController.text);

                      if(response.statusCode == 200){
                        http.Response usernameResponse = await requestUtil.getName(emailController.text);
                        Map decodedUsernameResponse = json.decode(usernameResponse.body);
                        String username = decodedUsernameResponse['user'];
                        userController.setUser(username, emailController.text, passwordController.text);  
                        Get.offAndToNamed(AppPages.HOME);  
                        emailController.clear();
                        passwordController.clear();
                      }else{
                        Map decodedResponse = json.decode(response.body);
                        if(response.statusCode == 422){  //Error por campos de texto vacios
                          String error = decodedResponse['detail'].elementAt(0)['msg'];
                          if(context.mounted){
                            cupertinoDialog(context, error, 'Error', () => Navigator.pop(context));
                          }
                        }else{  //Error por email o contraseña incorrectas
                          String error = decodedResponse['detail'];
                          if(context.mounted){
                            cupertinoDialog(context, error, 'Error', () => Navigator.pop(context));
                          }
                        }
                      }
                    }catch(e){
                      cupertinoDialog(context, e.toString(), 'Error', () => Get.offAndToNamed(AppPages.LOGIN));
                    }
                  },
                  containerColor: Colors.black,
                  textColor: Colors.white,
                  text: 'Log In',
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
                Button(
                  onTap: () => Get.offAndToNamed(AppPages.SIGNUP),
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

