import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tslfpc/crear.dart';
import 'package:tslfpc/tarea_cubit.dart';

class Guardar extends StatefulWidget {
  static String id = 'guardar';

  @override
  _GuardarState createState() => _GuardarState();
}

class _GuardarState extends State<Guardar> {
  @override
  Widget build(BuildContext context) {
    final tareaCubit = context.watch<TareaCubit>();
    final datosGuardados = tareaCubit.state.datosGuardados;

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
              datosGuardados.isEmpty
                  ? Text(
                      'No tiene ninguna tarea registrada',
                      style: TextStyle(
                        fontSize: 20.0,
                      ),
                    )
                  : Expanded(
                      child: ListView.builder(
                        itemCount: datosGuardados.length,
                        itemBuilder: (context, index) {
                          final tarea =
                              datosGuardados[index]['tarea']!.contains(', ')
                                  ? datosGuardados[index]['tarea']!.split(', ')
                                  : [datosGuardados[index]['tarea']!, ''];
                          final etiqueta = datosGuardados[index]['etiqueta']!;

                          return ListTile(
                            title: Text('Nombre de tarea: ' + tarea[0]),
                            subtitle: Text('Fecha límite de la tarea: ' +
                                tarea[1] +
                                '\n' +
                                'Etiqueta de tarea: ' +
                                etiqueta),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon: Icon(Icons.edit),
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (context) {
                                        String nombreTarea = tarea[0];
                                        DateTime fechaTarea =
                                            DateTime.parse(tarea[1]);
                                        String etiquetaTarea = etiqueta;

                                        return StatefulBuilder(
                                          builder: (context, setState) {
                                            return AlertDialog(
                                              content: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  TextField(
                                                    onChanged: (value) {
                                                      nombreTarea = value;
                                                    },
                                                    decoration: InputDecoration(
                                                      labelText:
                                                          'Nombre de tarea',
                                                    ),
                                                    controller:
                                                        TextEditingController(
                                                            text: nombreTarea),
                                                  ),
                                                  TextField(
                                                    onChanged: (value) {
                                                      fechaTarea =
                                                          DateTime.parse(value);
                                                    },
                                                    decoration: InputDecoration(
                                                      labelText:
                                                          'Fecha de tarea (YYYY-MM-DD)',
                                                    ),
                                                    controller:
                                                        TextEditingController(
                                                            text: fechaTarea
                                                                .toIso8601String()),
                                                  ),
                                                  TextField(
                                                    onChanged: (value) {
                                                      etiquetaTarea = value;
                                                    },
                                                    decoration: InputDecoration(
                                                      labelText:
                                                          'Etiqueta de tarea',
                                                    ),
                                                    controller:
                                                        TextEditingController(
                                                            text:
                                                                etiquetaTarea),
                                                  ),
                                                ],
                                              ),
                                              actions: [
                                                TextButton(
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                  child: Text('Cancelar'),
                                                ),
                                                TextButton(
                                                  onPressed: () {
                                                    Map<String, String>
                                                        nuevaTarea = {
                                                      'tarea':
                                                          '$nombreTarea, ${fechaTarea.toIso8601String()}',
                                                      'etiqueta': etiquetaTarea
                                                    };
                                                    tareaCubit.editarDato(
                                                        index, nuevaTarea);
                                                    Navigator.pop(context);
                                                  },
                                                  child: Text('Guardar'),
                                                ),
                                              ],
                                            );
                                          },
                                        );
                                      },
                                    );
                                  },
                                ),
                                IconButton(
                                  icon: Icon(Icons.delete),
                                  onPressed: () {
                                    tareaCubit.eliminarDato(index);
                                  },
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
              SizedBox(
                height: 20,
              ),
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
