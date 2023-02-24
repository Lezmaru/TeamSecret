import 'package:flutter/material.dart';
import 'package:tslfpc/crear.dart';

class Guardar extends StatefulWidget {
  final String nombreTarea;
  final String fechaTarea;
  final String etiquetaTarea;
  static String id = 'guardar';

  const Guardar(
      {super.key,
      required this.nombreTarea,
      required this.fechaTarea,
      required this.etiquetaTarea});
  @override
  _GuardarState createState() => _GuardarState();
}

class _GuardarState extends State<Guardar> {
  TextEditingController _nombreTareaController = TextEditingController();
  TextEditingController _fechaTareaController = TextEditingController();
  TextEditingController _etiquetaTareaController = TextEditingController();
  @override
  void initState() {
    super.initState();
    _nombreTareaController.text = widget.nombreTarea;
  }

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
              TextFormField(
                controller: _nombreTareaController,
                decoration: InputDecoration(
                  labelText: 'Nombre de la tarea',
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
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) {
                  return Crear();
                }),
              );
            }),
      );
    });
  }
}
