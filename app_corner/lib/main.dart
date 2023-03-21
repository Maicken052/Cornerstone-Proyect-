import 'package:flutter/material.dart'; //Importar widgets de flutter

void main() => runApp(App()); //Funcion void que ejecuta el primer widget de la aplicación

class App extends StatelessWidget { 
const App({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context){ //Crear la app con estilo 'Material'
    return MaterialApp(
      title: "Pet Feed",
      home: Inicio(),
    );
  }
}

class Inicio extends StatefulWidget {  
  const Inicio({super.key});

  @override
  State<Inicio> createState() => _InicioState();
}

class _InicioState extends State<Inicio> { //Cuerpo de la app
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pet Feed"), //Titulo de la barra principal
      ),
      body: Column( //Columna principal
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[

          Container(  //Logo de la esquina
            padding: EdgeInsets.all(5.0),
            width: MediaQuery.of(context).size.width,
            height: 50.0,
            child: Align(
              alignment: Alignment.topRight,
              child: Image.asset('images/logo.png'),
            ),    
          ),

          Row(  //Row para colocar el rectangulo azul
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[

              Expanded(
                child: Container(  //Rectangulo azul
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    color: Color.fromARGB(255, 221, 229, 235)
                  ),
                  
                  child: Column(  //Columna con la foto y el texto 
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      
                      SizedBox(  //!Separador
                        height: 10
                      ),

                      ClipOval(  //Foto de bienvenida
                        child: Image.asset(
                          "images/dog.jpg",  //TODO: Hacer que esto se pueda cambiar a gusto
                          width: 170,
                          height: 170,
                          ),
                      ),

                      SizedBox(  //!Separador
                        height: 20,
                      ),

                      Text(  //Texto de bienvenida
                        "Hello, Sebastian!",  //TODO: Hacer que esto cambie según el deuño
                        style: TextStyle(
                          fontSize: 30,
                          fontFamily: 'JosefinSans',
                          color: Color.fromARGB(255, 48, 42, 42),
                        )
                      ),
                    ]
                  )
                ),
              ),
            ]
          ),
        
        SizedBox(  //!Separador
          height: 20,
        ),

        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            
            Container(
              width: 170,
              child: Text(
                "Your pets:",
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontSize: 20,
                  fontFamily: 'JosefinSans',
                  color: Color.fromARGB(255, 42, 55, 243),
                )
              ),
            ),

            ElevatedButton(
              child: Image.asset(
                'images/your_pets.png',
                width: 140,
                height: 160,
              ),
              onPressed: null,  //TODO: Agregar lógica del botón
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20), 
                ),
              ),
            ),
          ],
        ),

        SizedBox(  //!Separador
          height: 30,
        ),

        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            
            Container(
              width: 170,
              child: Text(
                "Add pet:",
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontSize: 20,
                  fontFamily: 'JosefinSans',
                  color: Color.fromARGB(255, 42, 55, 243),
                )
              ),
            ),

            ElevatedButton(
              child: Image.asset(
                'images/add_pet.png',
                width: 140,
                height: 160,
              ),
              onPressed: null,  //TODO: Agregar lógica del botón
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20), 
                ),
              ),
            ),
          ],
        ),

        ]
      )
    );
  }
}



