import 'package:flutter/cupertino.dart';

dynamic cupertinoDialog(BuildContext context, String text, String title, Function()? function){
  Navigator.pop(context);  //Cerrar el circular progress indicator
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
        text,
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