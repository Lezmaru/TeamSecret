import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'etiquetas.dart';
import 'guardar.dart';
import 'tarea_cubit.dart'; // Importa el Cubit

class Crear extends StatefulWidget {
  static String id = 'crear';

  @override
  _CrearState createState() => _CrearState();
}

class _CrearState extends State<Crear> {
  String _nombreTarea = '';
  DateTime _fechaTarea = DateTime.now();
  String _etiquetaTarea = 'trabajo';

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
            SizedBox(
              height: 15.0,
            ),
            AppBar(
              title: Text('Registrar Nueva Tarea'),
              backgroundColor: Color.fromARGB(255, 0, 0, 0),
            ),
            SizedBox(
              height: 20,
            ),
            _nombretareaTextField(),
            SizedBox(
              height: 20,
            ),
            Text(
              'Fecha de Cumplimiento:',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            _fechatareaTextField(),
            SizedBox(
              height: 20,
            ),
            Text(
              'Etiquetas:',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            _etiquetasDropdown(),
            SizedBox(
              height: 60,
            ),
            _bottonGuardar(),
          ]),
        ),
      ),
    );
  }

  Widget _nombretareaTextField() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 400.0),
      child: TextField(
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          floatingLabelStyle:
              MaterialStateTextStyle.resolveWith((Set<MaterialState> states) {
            return TextStyle(
              color: Color.fromARGB(255, 0, 0, 0),
            );
          }),
          icon: Icon(
            Icons.text_fields,
          ),
          iconColor: Color.fromARGB(255, 122, 120, 120),
          hintText: 'Ej: Hacer la tarea de matemáticas',
          labelText: 'Nombre de la Tarea',
        ),
        onChanged: (value) {
          _nombreTarea = value;
        },
      ),
    );
  }

  Widget _fechatareaTextField() {
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
              _fechaTarea.toString(),
              style: TextStyle(
                fontSize: 20.0,
              ),
            ),
          ),
          onPressed: () {
            showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(2023),
              lastDate: DateTime(2050),
            ).then(
              (value) {
                if (value != null) {
                  setState(() {
                    _fechaTarea = value;
                  });
                }
              },
            );
          }),
    );
  }

  Widget _etiquetasDropdown() {
    return BlocBuilder<TareaCubit, TareaState>(
      builder: (context, state) {
        if (state is TareaLoaded) {
          return DropdownButton<String>(
            value: _etiquetaTarea,
            items: state.datosGuardados.map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            onChanged: (String? newValue) {
              setState(() {
                _etiquetaTarea = newValue!;
              });
            },
          );
        } else {
          return CircularProgressIndicator();
        }
      },
    );
  }

  Widget _bottonGuardar() {
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
              'Guardar',
              style: TextStyle(
                fontSize: 20.0,
              ),
            ),
          ),
          onPressed: () {
            context.read<TareaCubit>().guardar(
                  _nombreTarea,
                  _fechaTarea,
                  _etiquetaTarea,
                );

            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) {
                return Guardar();
              }),
            );
          }),
    );
  }
}
