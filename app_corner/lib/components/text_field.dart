import 'package:flutter/material.dart';

class MyTextField extends StatefulWidget{ 
  final TextEditingController? controller;  
  final String? hintText;  
  final bool hide;  //Indica si el texto del campo de texto está oculto
  final bool passwordField;  //Indica si el campo de texto es de tipo password(texto oculto)
  final Widget? prefix; 

  const MyTextField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.hide,
    required this.passwordField,
    required this.prefix,
  });

  @override
  State<MyTextField> createState() => _MyTextFieldState();
}

class _MyTextFieldState extends State<MyTextField>{
  bool hide = false;

  @override
  void initState() {
    super.initState();
    hide = widget.hide; //Inicializa el valor de hide con el valor de widget.hide dado en la ruta actual para modificarlo a gusto
  }

  @override
  Widget build(BuildContext context){ 
    //Si passwordField; es true, se muestra el icono de visibilidad, sino se deja un vacío
    Widget? suffix;  
    if(widget.passwordField){
      suffix = GestureDetector(
        onTap: (){
          setState(() {
            hide = !hide;
          });
        },
        child: Icon(hide ? Icons.visibility_off : Icons.visibility)
      );
    }else{
      suffix = const Offstage(
        child: Icon(Icons.email)
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal:40.0),
      child: TextField(
        controller: widget.controller,
        obscureText: hide,
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey[600]!)
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blue)
          ),
          fillColor: Colors.grey[300]!,
          filled: true,
          hintText: widget.hintText,
          hintStyle: TextStyle(
            fontSize: 16.0,
            fontFamily: 'JosefinSans',
            color: Colors.grey[600],
          ),
          prefixIcon: widget.prefix,
          suffixIcon: suffix,
        ),
        style: const TextStyle(
          fontSize: 16.0,
          fontFamily: 'JosefinSans',
          color: Colors.black,
        ),
      )
    );
  }
}