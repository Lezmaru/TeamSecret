// login.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tslfpc/menu.dart';
import 'login_cubit.dart';
import 'login_state.dart';

class Login extends StatefulWidget {
  static String id = 'login';
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: SafeArea(
        child: Scaffold(
          body: BlocConsumer<LoginCubit, LoginState>(
            listener: (context, state) {
              if (state is LoginFailure) {
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text(state.error)));
              } else if (state is LoginSuccess) {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Menu()),
                );
              }
            },
            builder: (context, state) {
              return Center(
                child: Column(
                  children: [
                    Image.asset(
                      'images/logo.png',
                      height: 200.0,
                    ),
                    SizedBox(
                      height: 35.0,
                    ),
                    _userTextField(),
                    SizedBox(
                      height: 20,
                    ),
                    _passwordTextField(),
                    SizedBox(
                      height: 20,
                    ),
                    state is LoginLoading
                        ? CircularProgressIndicator()
                        : _bottonLogin(),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _userTextField() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: TextField(
        controller: _usernameController,
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
        controller: _passwordController,
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
    return BlocBuilder<LoginCubit, LoginState>(
      builder: (context, state) {
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
          onPressed: state is LoginLoading
              ? null
              : () {
                  context.read<LoginCubit>().logIn(
                        _usernameController.text,
                        _passwordController.text,
                      );
                },
        );
      },
    );
  }
}
