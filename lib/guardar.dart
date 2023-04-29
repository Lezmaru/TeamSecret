import 'package:flutter/material.dart';
import 'package:tslfpc/crear.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tslfpc/tarea_cubit.dart';

class Guardar extends StatelessWidget {
  final String nombreTarea;
  final DateTime fechaTarea;
  final String etiquetaTarea;
  static String id = 'guardar';

  const Guardar({
    Key? key,
    required this.nombreTarea,
    required this.fechaTarea,
    required this.etiquetaTarea,
    required String buttonText,
    required String buttonText2,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
            children: [
              // Resto del código
              _bottonCrear(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _bottonCrear(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 200.0),
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
            context.read<TareaCubit>().agregarDato(nombreTarea);
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) {
                return BlocProvider.value(
                  value: context.read<TareaCubit>(),
                  child: Crear(),
                );
              }),
            );
          }),
    );
  }
}
