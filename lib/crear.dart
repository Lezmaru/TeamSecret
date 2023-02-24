import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:tslfpc/guardar.dart';

class Crear extends StatefulWidget {
  static String id = 'crear';
  @override
  _CrearState createState() => _CrearState();
}

class _CrearState extends State<Crear> {
  @override
  String _nombreTarea = '';
  String _fechaTarea = '';
  String _etiquetaTarea = 'trabajo';
  DateTime selectedDate = DateTime.now();
  String _dateText = 'Seleccionar fecha';
  var _currentSelectedDate;
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
            DropdownButton(
              value: _etiquetaTarea,
              items: _dropdownItems,
              onChanged: (value) {
                setState(() {
                  _etiquetaTarea = value!;
                });
              },
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
                      _fechaTarea = value.toString();
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

List<DropdownMenuItem<String>> _dropdownItems = [
  DropdownMenuItem(
    child: Text('Trabajo'),
    value: 'trabajo',
  ),
  DropdownMenuItem(
    child: Text('Casa'),
    value: 'casa',
  ),
  DropdownMenuItem(
    child: Text('Personal'),
    value: 'personal',
  ),
];
