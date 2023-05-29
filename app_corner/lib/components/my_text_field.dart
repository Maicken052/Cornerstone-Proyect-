import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget { 
  final TextEditingController controller;
  final String hintText;
  final bool hide;

  const MyTextField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.hide,
  });

  @override
  Widget build(BuildContext context){ 
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal:40.0),
      child: TextField(
        controller: controller,
        obscureText: hide,
        decoration: InputDecoration(
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Color.fromARGB(255, 100, 100, 100))
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blue)
          ),
          fillColor:const Color.fromARGB(255, 228, 225, 225),
          filled: true,
          hintText: hintText,
          hintStyle: TextStyle(
            fontSize: 16.0,
            fontFamily: 'JosefinSans',
            color: Colors.grey[600],
          )
        )
      )
    );
  }
}