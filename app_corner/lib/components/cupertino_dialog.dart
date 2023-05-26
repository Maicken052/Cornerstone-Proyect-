import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

dynamic cupertinoDialog(BuildContext context, String msg){
  return showCupertinoDialog(
    context: context,
    builder: (BuildContext context) => CupertinoAlertDialog(
      title: const Text(
        'Error',
        style: TextStyle(fontSize: 22),
      ),
      content: Text(
        msg,
        style: const TextStyle(fontSize: 16),
      ),
      actions: [
        CupertinoDialogAction(
          textStyle: const TextStyle(
          ),
          onPressed: () => Navigator.pop(context),
          child: const Text('OK'),
        )
      ]
    )
  );
}