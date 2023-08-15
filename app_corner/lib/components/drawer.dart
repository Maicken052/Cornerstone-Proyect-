import 'package:flutter/material.dart';
import 'dart:typed_data';
import 'package:get/get.dart';
import '../components/firebase_util.dart';
import '../components/image_picker.dart';
import '../controllers/user_controller.dart'; 
import '../routes/app_pages.dart';
import '../components/cupertino_dialog.dart';


class Sidebar extends StatefulWidget{
  const Sidebar({super.key});

  @override
  State<Sidebar> createState() => _SidebarState();
}

class _SidebarState extends State<Sidebar>{
  //Buscar el controlador de usuario para usar la info de la persona
  final UserController userController = Get.find<UserController>();
  //objeto para hacer peticiones a firebase
  final FirebaseUtil firebaseUtil = FirebaseUtil();
  //imagenes asociadas al usuario
  final Rx<Uint8List> profileImage = Rx<Uint8List>(Uint8List(0));
  final Rx<Uint8List> backgroundImage = Rx<Uint8List>(Uint8List(0));
  //links de las imagenes asociadas al usuario
  String profileImageLink = '';
  String backgroundImageLink = '';

  Future fetchUserImage() async{
    try{
      profileImageLink = await firebaseUtil.getImageLink(userController.email.value, 'user', 'profile');
      backgroundImageLink = await firebaseUtil.getImageLink(userController.email.value, 'user', 'banner');
      return 'done';
    }catch(e){
      return null;
    }
  }

  @override
  Widget build(BuildContext context){
    return Drawer(
      backgroundColor: Colors.grey[200],
      child: FutureBuilder(
        future: fetchUserImage(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
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
            return ListView(
              padding: EdgeInsets.zero, //Hace que el banner empiece desde el borde superior
              children: [
                Stack(
                  children: [
                    Container(
                      height: 100,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: backgroundImageLink != 'no image' ?
                            NetworkImage(backgroundImageLink) as ImageProvider
                            : const AssetImage("images/background.png")
                        ),
                      ),
                    ),
                    
                    UserAccountsDrawerHeader(
                      accountName: Text(
                        userController.username.value,
                        style: const TextStyle(
                          fontSize: 15.0,
                          fontFamily: 'JosefinSans',
                          fontWeight: FontWeight.bold,
                          color: Colors.black
                        )
                      ),
                      accountEmail: Text(
                        userController.email.value,
                        style: const TextStyle(
                          fontSize: 15.0,
                          fontFamily: 'JosefinSans',
                          color: Colors.black54
                        )
                      ),
                      currentAccountPicture: profileImageLink != 'no image' ?
                        CircleAvatar( 
                          backgroundColor: Colors.white,
                          child: CircleAvatar(
                            radius: 34.0,
                            backgroundImage: NetworkImage(profileImageLink),
                            backgroundColor: Colors.white
                          )
                        ) :
                        const CircleAvatar( 
                          backgroundColor: Colors.white,
                          child: CircleAvatar(
                            radius: 34.0,
                            backgroundImage: AssetImage('images/default_user.png'),
                            backgroundColor: Colors.white
                          )
                        ),
                      decoration: const BoxDecoration(
                          color: Colors.transparent, 
                      ),
                    ),
                  ],
                ),   

                ListTile(
                  title: const Text(
                    'Change profile picture',
                    style: TextStyle(
                      fontSize: 15.0,
                      fontFamily: 'JosefinSans',
                      color: Colors.black
                    )
                  ),
                  leading: const Icon(Icons.portrait_rounded),
                  onTap: () async{
                    profileImage.value = await pickImage();
                    try{
                      if(profileImage.value.lengthInBytes != 0){
                        if(context.mounted){
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
                        }
                        //Si el usuario ya tiene foto de perfil, la actualiza, sino la guarda en la base de datos
                        if(profileImageLink != 'no image'){ 
                          await firebaseUtil.updateData(userController.email.value, 'user', 'profile', profileImage.value);
                        }else{
                          await firebaseUtil.saveData(userController.email.value, 'user', 'profile',  profileImage.value);
                        }
                        String profileImageLink_ = await firebaseUtil.getUrl(userController.email.value, 'user', 'profile');
                        setState(() {
                          profileImageLink = profileImageLink_;
                        });
                        if(context.mounted){
                          Navigator.pop(context);
                        }
                      }else{
                        null;
                      }
                    }catch(e){
                      if(context.mounted){
                        cupertinoDialog(context, e.toString(), 'Error', () => Get.offAndToNamed(AppPages.HOME));
                      }
                    }
                  },
                ),

                ListTile(
                  title: const Text(
                    'Change background picture',
                    style: TextStyle(
                      fontSize: 15.0,
                      fontFamily: 'JosefinSans',
                      color: Colors.black
                    )
                  ),
                  leading: const Icon(Icons.add_a_photo_outlined),
                  onTap: () async{
                    backgroundImage.value = await pickImage();
                    try{
                      if(backgroundImage.value.lengthInBytes != 0){
                        if(context.mounted){
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
                        }
                        //Si el usuario ya tiene foto de banner, la actualiza, sino la guarda en la base de datos
                        if(backgroundImageLink != 'no image'){ 
                          await firebaseUtil.updateData(userController.email.value, 'user', 'banner',  backgroundImage.value);
                        }else{
                          await firebaseUtil.saveData(userController.email.value, 'user', 'banner',  backgroundImage.value);
                        }
                        String backgroundImageLink_ = await firebaseUtil.getUrl(userController.email.value, 'user', 'banner');
                        setState(() {
                          backgroundImageLink = backgroundImageLink_;
                        });
                        if(context.mounted){
                          Navigator.pop(context);
                        }
                      }else{
                        null;
                      }
                    }catch(e){ 
                      if(context.mounted){
                        cupertinoDialog(context, e.toString(), 'Error', () => Get.offAndToNamed(AppPages.HOME));
                      }                      
                    }                   
                  },
                ),
                
                ListTile(
                  title: const Text(
                    'Log out',
                    style: TextStyle(
                      fontSize: 15.0,
                      fontFamily: 'JosefinSans',
                      color: Colors.black
                    )
                  ),
                  leading: const Icon(Icons.exit_to_app),
                  onTap: () => Get.offAllNamed(AppPages.LOGIN),
                ),
              ],
            );
          }else{
            return const Center(
              child: Text(
                'some error occurred',
                style: TextStyle(
                  fontSize: 30.0,
                  fontFamily: 'JosefinSans',
                  color: Colors.black
                )
              ),
            );
          }
        }
      ),
    );
  }
}
