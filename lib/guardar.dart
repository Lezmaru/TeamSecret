import 'package:flutter/material.dart';
import 'package:tslfpc/crear.dart';

class Guardar extends StatefulWidget {
  final String nombreTarea;
  final DateTime fechaTarea;
  final String etiquetaTarea;
  final String buttonText;
  final String buttonText2;
  static String id = 'guardar';

  const Guardar({
    super.key,
    required this.nombreTarea,
    required this.fechaTarea,
    required this.etiquetaTarea,
    required this.buttonText,
    required this.buttonText2,
  });
  @override
  _GuardarState createState() => _GuardarState();
}

class _GuardarState extends State<Guardar> {
  TextEditingController _nombreTareaController = TextEditingController();
  TextEditingController _fechaTareaController = TextEditingController();
  TextEditingController _etiquetaTareaController = TextEditingController();
  bool _isHovering = false;
  bool _isCompleted = false;
  bool _isCompleted2 = false;
  String _buttonText = 'Completar';
  String _buttonText2 = 'Pendiente';
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
                      child: ElevatedButton(
                        onPressed: () async {
                          setState(() {
                            _isCompleted = !_isCompleted;
                            _buttonText = _isCompleted
                                ? 'Marcar como pendiente'
                                : 'Completar';
                            _isCompleted2 = !_isCompleted2;
                            _buttonText2 =
                                _isCompleted2 ? 'Pendiente' : 'Completado';
                          });
                          child:
                          Text(_isCompleted
                              ? "Marcar como pendiente"
                              : "Completar");
                          child:
                          Text(_isCompleted2 ? "Pendiente" : "Completado");
                          Navigator.pop(context, _isCompleted && _isCompleted2);
                          final result = await Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Guardar(
                                      buttonText: 'Marcar como pendiente',
                                      buttonText2: 'Completado',
                                      etiquetaTarea:
                                          '' + _etiquetaTareaController.text,
                                      fechaTarea: DateTime.parse(
                                          _fechaTareaController.text),
                                      nombreTarea:
                                          '' + _nombreTareaController.text,
                                    )),
                          );
                          // Si el usuario completó el texto, actualiza el estado del texto y muestra "Marcar como pendiente"
                          if (result != null && result) {
                            setState(() {
                              _isCompleted = true;
                              _isCompleted2 = true;
                              _buttonText = "Marcar como pendiente";
                              _buttonText2 = "Completado";
                            });
                          }
                          // Si el usuario marcó el texto como pendiente, actualiza el estado del texto y muestra "Completar"
                          if (result != null && !result) {
                            setState(() {
                              _isCompleted = false;
                              _isCompleted2 = false;
                              _buttonText = "Completar";
                              _buttonText2 = "Pendiente";
                            });
                          }
                        },
                        child: Text(
                          '$_buttonText',
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
                    child: Text('$_buttonText2'),
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
                    agregarDato: (String nuevoDato) {},
                    editarDato: (int indice, String nuevoDato) {},
                    eliminarDato: (int indice) {},
                  );
                }),
              );
            }),
      );
    });
  }
}
