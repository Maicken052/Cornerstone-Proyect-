import 'package:flutter/cupertino.dart';

dynamic cupertinoDialog(BuildContext context, String msg, String title, Function()? function){
  return showCupertinoDialog(
    context: context,
    builder: (BuildContext context) => CupertinoAlertDialog(

      //Título del diálogo
      title: Text(
        title,
        style: const TextStyle(fontSize: 22)
      ),

      //Contenido del diálogo
      content: Text(
        msg,
        style: const TextStyle(fontSize: 16)
      ),

      //Botón de acción
      actions: [
        CupertinoDialogAction(
          textStyle: const TextStyle(
          ),
          onPressed: function,
          child: const Text('OK')
        )
      ]
    )
  );
}