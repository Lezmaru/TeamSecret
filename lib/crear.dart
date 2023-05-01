import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'guardar.dart';
import 'tarea_cubit.dart';

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
              actions: [_manageTagsButton()], // Agregado aquí
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
          List<String> etiquetas = state.etiquetas;

          if (!etiquetas.contains(_etiquetaTarea)) {
            _etiquetaTarea = etiquetas.isNotEmpty ? etiquetas[0] : '';
          }

          return DropdownButton<String>(
            value: _etiquetaTarea,
            items: etiquetas.map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            onChanged: (String? newValue) {
              setState(() {
                _etiquetaTarea = newValue ?? '';
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

  Future<void> _manageTagsDialog() async {
    String? nuevaEtiqueta;
    String? etiquetaSeleccionada;

    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Gestionar Etiquetas'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Añadir Etiqueta:'),
                TextField(
                  onChanged: (value) {
                    nuevaEtiqueta = value;
                  },
                ),
                SizedBox(height: 10),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.black,
                  ),
                  child: Text('Añadir'),
                  onPressed: () {
                    if (nuevaEtiqueta != null && nuevaEtiqueta!.isNotEmpty) {
                      context
                          .read<TareaCubit>()
                          .agregarEtiqueta(nuevaEtiqueta!);
                      Navigator.of(context).pop();
                    }
                  },
                ),
                SizedBox(height: 10),
                Text('Editar o Eliminar Etiqueta:'),
                BlocBuilder<TareaCubit, TareaState>(
                  builder: (context, state) {
                    if (state is TareaLoaded) {
                      List<String> etiquetas =
                          context.read<TareaCubit>().etiquetas;
                      if (!etiquetas.contains(etiquetaSeleccionada)) {
                        etiquetaSeleccionada =
                            etiquetas.isNotEmpty ? etiquetas[0] : '';
                      }

                      return DropdownButton<String>(
                        value: etiquetaSeleccionada,
                        items: etiquetas.map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          etiquetaSeleccionada = newValue ?? '';
                        },
                      );
                    } else {
                      return CircularProgressIndicator();
                    }
                  },
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.black,
                  ),
                  child: Text('Editar'),
                  onPressed: () {
                    if (etiquetaSeleccionada != null &&
                        etiquetaSeleccionada!.isNotEmpty) {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('Editar Etiqueta'),
                              content: TextField(
                                onChanged: (value) {
                                  nuevaEtiqueta = value;
                                },
                              ),
                              actions: <Widget>[
                                TextButton(
                                  child: Text('Guardar'),
                                  onPressed: () {
                                    if (nuevaEtiqueta != null &&
                                        nuevaEtiqueta!.isNotEmpty) {
                                      context.read<TareaCubit>().editarEtiqueta(
                                          etiquetaSeleccionada!,
                                          nuevaEtiqueta!);
                                      Navigator.of(context).pop();
                                    }
                                  },
                                ),
                                TextButton(
                                  child: Text('Cancelar'),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            );
                          });
                    }
                  },
                ),
                SizedBox(height: 10),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.black,
                  ),
                  child: Text('Eliminar'),
                  onPressed: () {
                    if (etiquetaSeleccionada != null &&
                        etiquetaSeleccionada!.isNotEmpty) {
                      context
                          .read<TareaCubit>()
                          .eliminarEtiqueta(etiquetaSeleccionada!);
                      Navigator.of(context).pop();
                    }
                  },
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cerrar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Widget _manageTagsButton() {
    return IconButton(
      icon: Icon(Icons.manage_search),
      onPressed: () {
        _manageTagsDialog();
      },
    );
  }
}
