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
                          final datos = datosGuardados[index].split(', ');

                          if (datos.length < 3) {
                            while (datos.length < 3) {
                              datos.add('Valor no definido');
                            }
                          }

                          return ListTile(
                            title: Text('Nombre de tarea: ' + datos[0]),
                            subtitle: Text('Fecha de tarea: ' +
                                datos[1] +
                                '\n' +
                                'Etiqueta de tarea: ' +
                                datos[2]),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon: Icon(Icons.edit),
                                  onPressed: () {
                                    // Aquí puedes navegar a una nueva página para editar la tarea
                                    // Pasarías `index` y los datos actuales para rellenar los campos de entrada
                                  },
                                ),
                                IconButton(
                                  icon: Icon(Icons.delete),
                                  onPressed: () {
                                    // Aquí puedes eliminar la tarea
                                    tareaCubit.eliminar(index);
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
