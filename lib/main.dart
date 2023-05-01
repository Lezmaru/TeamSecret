import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tslfpc/login.dart';
import 'package:tslfpc/tarea_cubit.dart';

import 'crear.dart';
import 'menu.dart';

void main() {
  runApp(
    BlocProvider(
      create: (context) => TareaCubit(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: Login.id,
      routes: {
        Login.id: (context) => Login(),
        Menu.id: (context) => Menu(),
        Crear.id: (context) => BlocProvider(
              create: (context) => TareaCubit(),
              child: Crear(),
            ),
      },
    );
  }
}
