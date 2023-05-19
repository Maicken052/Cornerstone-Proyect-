// ignore_for_file: prefer_const_constructors, prefer_interpolation_to_compose_strings, avoid_print, sized_box_for_whitespace, todo, prefer_const_literals_to_create_immutables, unused_import, file_names
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
      padding: EdgeInsets.symmetric(horizontal:40.0),
      child: TextField(
        controller: controller,
        obscureText: hide,
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color.fromARGB(255, 100, 100, 100))
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blue)
          ),
          fillColor:Color.fromARGB(255, 228, 225, 225),
          filled: true,
          hintText: hintText,
          hintStyle: TextStyle(
            fontSize: 16.0,
            fontFamily: 'JosefinSans',
            color: Colors.grey[600],
          )
        )
      ),
    );
  }
}