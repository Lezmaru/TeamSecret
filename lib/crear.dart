import 'package:flutter/material.dart';

class Crear extends StatefulWidget {
  static String id = 'crear';
  @override
  _CrearState createState() => _CrearState();
}

class _CrearState extends State<Crear> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(children: [
            Image.asset(
              'images/logo.png',
              height: 100.0,
            ),
            AppBar(
              title: Text('Registrar Nueva Tarea'),
              backgroundColor: Color.fromARGB(255, 0, 0, 0),
            ),
            SizedBox(
              height: 15.0,
            ),
          ]),
        ),
      ),
    );
  }
}
