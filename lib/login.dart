import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tslfpc/menu.dart';
import 'package:tslfpc/tarea_cubit.dart';

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
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: TextField(
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          icon: Icon(
            Icons.email,
          ),
          hintText: 'Usuario',
          labelText: 'Usuario',
        ),
      ),
    );
  }

  Widget _passwordTextField() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: TextField(
        obscureText: true,
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          icon: Icon(Icons.lock),
          hintText: 'Contraseña',
          labelText: 'Contraseña',
        ),
      ),
    );
  }

  Widget _bottonLogin() {
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
        // No se requiere autenticación para navegar a la página Menu.
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) {
            return Menu();
          }),
        );
      },
    );
  }
}
