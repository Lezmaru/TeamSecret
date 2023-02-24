import 'package:flutter/material.dart';
import 'package:tslfpc/menu.dart';

class Login extends StatefulWidget {
  static String id = 'login';
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
            children: [
              Image.asset(
                'images/logo.png',
                height: 200.0,
              ),
              SizedBox(
                height: 15.0,
              ),
              SizedBox(
                height: 20,
              ),
              _userTextField(),
              SizedBox(
                height: 20,
              ),
              _passwordTextField(),
              SizedBox(
                height: 20,
              ),
              _bottonLogin(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _userTextField() {
    return StreamBuilder(
        builder: (BuildContext context, AsyncSnapshot snapshot) {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: TextField(
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            floatingLabelStyle:
                MaterialStateTextStyle.resolveWith((Set<MaterialState> states) {
              return TextStyle(
                color: Color.fromARGB(255, 0, 0, 0),
              );
            }),
            icon: Icon(
              Icons.email,
            ),
            iconColor: Color.fromARGB(255, 122, 120, 120),
            hintText: 'Usuario',
            labelText: 'Usuario',
          ),
        ),
      );
    });
  }

  Widget _passwordTextField() {
    return StreamBuilder(
        builder: (BuildContext context, AsyncSnapshot snapshot) {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: TextField(
          obscureText: true,
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            floatingLabelStyle:
                MaterialStateTextStyle.resolveWith((Set<MaterialState> states) {
              return TextStyle(
                color: Color.fromARGB(255, 0, 0, 0),
              );
            }),
            icon: Icon(Icons.lock),
            iconColor: Color.fromARGB(255, 122, 120, 120),
            hintText: 'Contraseña',
            labelText: 'Contraseña',
          ),
        ),
      );
    });
  }

  Widget _bottonLogin() {
    return StreamBuilder(
        builder: (BuildContext context, AsyncSnapshot snapshot) {
      return ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: Color.fromARGB(255, 0, 0, 0),
            onPrimary: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            elevation: 10.0,
          ),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 80.0, vertical: 15.0),
            child: Text('Ingresar'),
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) {
                return Menu();
              }),
            );
          });
    });
  }
}
