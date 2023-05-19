// ignore_for_file: prefer_const_constructors, prefer_interpolation_to_compose_strings, avoid_print, sized_box_for_whitespace, todo, prefer_const_literals_to_create_immutables, unused_import, file_names
import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {

  final Function()? onTap;
  final Color? containerColor;
  final Color? textColor;
  final String text;

  const MyButton({
    super.key,
    required this.onTap,
    required this.containerColor,
    required this.textColor,
    required this.text
    });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(25.0),
        margin: EdgeInsets.symmetric(horizontal: 25.0),
        decoration: BoxDecoration(
          color: containerColor,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: Colors.black,
            width: 2
          )
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
            fontSize: 16.0,
            fontFamily: 'JosefinSans',
            fontWeight: FontWeight.bold,
            color: textColor
            ),
          ),
        ),
      ),
    );
  }
}