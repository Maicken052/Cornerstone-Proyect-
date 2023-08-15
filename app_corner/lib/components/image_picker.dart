import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

Future<Uint8List> pickImage() async{
  ImagePicker imagePicker = ImagePicker();
  XFile? file = await imagePicker.pickImage(source: ImageSource.gallery);
  if(file != null){
    Uint8List img = await file.readAsBytes();
    return img;
  }
  return Uint8List(0); //Si no se selecciona ninguna imagen, se regresa una lista vacía
}


