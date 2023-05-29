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
        padding: const EdgeInsets.all(25.0),
        margin: const EdgeInsets.symmetric(horizontal: 25.0),
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
            )
          )
        )
      )
    );
  }
}