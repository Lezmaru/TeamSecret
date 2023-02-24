// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:tslfpc/etiquetas.dart';
import 'package:tslfpc/guardar.dart';

class Crear extends StatefulWidget {
  final List<String> datosGuardados;
  static String id = 'crear';

  Crear(
      {super.key,
      required this.datosGuardados,
      required Function(String nuevoDato) agregarDato,
      required Function(int indice, String nuevoDato) editarDato,
      required Function(int indice) eliminarDato});
  @override
  _CrearState createState() => _CrearState();
}

class _CrearState extends State<Crear> {
  @override
  String _etiquetaSeleccionada = '';
  String _nombreTarea = '';
  DateTime _fechaTarea = DateTime.now();
  String _etiquetaTarea = 'trabajo';
  DateTime selectedDate = DateTime.now();
  String _dateText = 'Seleccionar fecha';
  TextEditingController _textController = TextEditingController();
  List<String> _datosGuardados = ["trabajo", "estudio", "personal"];
  var _currentSelectedDate;
  void _agregarDato(String nuevoDato) {
    setState(() {
      _datosGuardados.add(nuevoDato);
    });
  }

  void _editarDato(int indice, String nuevoDato) {
    setState(() {
      _datosGuardados[indice] = nuevoDato;
    });
  }

  void _eliminarDato(int indice) {
    setState(() {
      _datosGuardados.removeAt(indice);
    });
  }

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
            _fechatareaTextField(context),
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
            SizedBox(
              width: MediaQuery.of(context).size.width / 2,
              child: Row(
                children: [
                  Expanded(
                    child: DropdownButton(
                      value: _etiquetaTarea,
                      items: _datosGuardados.map((String etiqueta) {
                        return DropdownMenuItem(
                          value: etiqueta,
                          child: Text(etiqueta),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          _etiquetaTarea = value!;
                        });
                      },
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Etiquetas(
                            datosGuardados: _datosGuardados,
                            agregarDato: _agregarDato,
                            editarDato: _editarDato,
                            eliminarDato: _eliminarDato,
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
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
    return StreamBuilder(
        builder: (BuildContext context, AsyncSnapshot snapshot) {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 400.0),
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
            hintText: 'Ej: Hacer la tarea de matemáticas',
            labelText: 'Nombre de la Tarea',
          ),
          onChanged: (value) {
            setState(() {
              _nombreTarea = value;
            });
          },
        ),
      );
    });
  }

  Widget _fechatareaTextField(BuildContext context) {
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
                selectedDate.toString(),
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
                      selectedDate = value;
                      _fechaTarea = value;
                    });
                  }
                },
              );
            }),
      );
    });
  }

  Widget _bottonGuardar() {
    return StreamBuilder(
        builder: (BuildContext context, AsyncSnapshot snapshot) {
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
                'Guardar',
                style: TextStyle(
                  fontSize: 20.0,
                ),
              ),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) {
                  return Guardar(
                    nombreTarea: _nombreTarea,
                    fechaTarea: _fechaTarea,
                    etiquetaTarea: _etiquetaTarea,
                  );
                }),
              );
            }),
      );
    });
  }
}
