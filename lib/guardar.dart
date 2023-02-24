import 'package:flutter/material.dart';
import 'package:tslfpc/crear.dart';

class Guardar extends StatefulWidget {
  final String nombreTarea;
  final DateTime fechaTarea;
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
  bool _isHovering = false;
  @override
  void initState() {
    super.initState();
    _nombreTareaController.text = widget.nombreTarea;
    _fechaTareaController.text = widget.fechaTarea.toString();
    _etiquetaTareaController.text = widget.etiquetaTarea;
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
              SizedBox(
                height: 15,
              ),
              Stack(
                children: [
                  Container(
                    padding: EdgeInsets.all(16),
                    decoration:
                        BoxDecoration(border: Border.all(color: Colors.black)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 7),
                        Text('Nombre de tarea: ' + _nombreTareaController.text),
                        SizedBox(height: 7),
                        Text('Fecha de tarea:' + _fechaTareaController.text),
                        SizedBox(height: 7),
                        Text('Etiqueta de tarea:' +
                            _etiquetaTareaController.text),
                      ],
                    ),
                  ),
                  Positioned(
                    right: 10,
                    bottom: 1,
                    child: MouseRegion(
                      cursor: SystemMouseCursors.click,
                      onEnter: (PointerEvent details) {
                        setState(() {
                          _isHovering = true;
                        });
                      },
                      onExit: (PointerEvent details) {
                        setState(() {
                          _isHovering = false;
                        });
                      },
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) {
                              return Guardar(
                                nombreTarea: _nombreTareaController.text,
                                fechaTarea:
                                    DateTime.parse(_fechaTareaController.text),
                                etiquetaTarea: _etiquetaTareaController.text,
                              );
                            }),
                          );
                        },
                        child: Text(
                          'Completar',
                          style: TextStyle(
                            color: _isHovering
                                ? Color.fromARGB(255, 255, 0, 0)
                                : Color.fromARGB(255, 0, 29, 174),
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 3,
                    left: 115,
                    bottom: 1,
                    child: Text('Pendiente'),
                  ),
                ],
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
                  return Crear(
                    datosGuardados: [],
                  );
                }),
              );
            }),
      );
    });
  }
}
