import 'package:flutter/material.dart';

class Menu extends StatefulWidget {
  static String id = 'menu';
  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
            children: [
              Image.asset(
                'images/logo.png',
                height: 100.0,
              ),
              SizedBox(
                height: 15.0,
              ),
              Text(
                'Bienvenido',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'No tiene ninguna tarea registrada',
                style: TextStyle(
                  fontSize: 20.0,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              _bottonCrear(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _bottonCrear() {
    return StreamBuilder(
        builder: (BuildContext context, AsyncSnapshot snapshot) {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: Color.fromARGB(255, 0, 0, 0),
            onPrimary: Color.fromARGB(255, 255, 255, 255),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(100),
            ),
          ),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 80.0, vertical: 15.0),
            child: Text(
              '+',
              style: TextStyle(
                fontSize: 20.0,
              ),
            ),
          ),
          onPressed: () {
            Navigator.pushNamed(context, Menu.id);
          },
        ),
      );
    });
  }
}
