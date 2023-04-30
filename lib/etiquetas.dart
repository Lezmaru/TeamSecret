import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tslfpc/tarea_cubit.dart';
import 'crear.dart';

void main() => runApp(
      BlocProvider(
        create: (context) => TareaCubit(),
        child: Etiquetas(),
      ),
    );

class Etiquetas extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Etiquetas',
      home: BlocBuilder<TareaCubit, TareaState>(
        builder: (context, state) {
          final tareaCubit = context.read<TareaCubit>();
          final datosGuardados = tareaCubit.state.datosGuardados;

          return Scaffold(
            appBar: AppBar(
              backgroundColor: Color.fromARGB(255, 0, 0, 0),
              title: const Text(
                'Etiquetas',
                textAlign: TextAlign.justify,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 2,
                        child: Row(
                          children: [
                            Expanded(
                              child: TextField(
                                onChanged: (value) {
                                  tareaCubit.agregarDato(
                                      {'etiqueta': value, 'tarea': ''});
                                },
                                decoration: const InputDecoration(
                                  hintText: 'Ingrese una etiqueta',
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {},
                        child: const Text(
                          'Agregar',
                          style: TextStyle(
                            color: Color.fromARGB(255, 0, 0, 0),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Divider(),
                  Expanded(
                    child: ListView.builder(
                      itemCount: datosGuardados.length,
                      itemBuilder: (BuildContext context, int index) {
                        final etiqueta =
                            datosGuardados[index]['etiqueta'] ?? '';
                        return ListTile(
                          title: Text(etiqueta),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              IconButton(
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      String nuevaEtiqueta = etiqueta;

                                      return StatefulBuilder(
                                        builder: (context, setState) {
                                          return AlertDialog(
                                            content: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                TextField(
                                                  onChanged: (value) {
                                                    nuevaEtiqueta = value;
                                                  },
                                                  decoration: InputDecoration(
                                                    labelText: 'Etiqueta',
                                                  ),
                                                  controller:
                                                      TextEditingController(
                                                          text: nuevaEtiqueta),
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
                                                  tareaCubit.editarDato(index, {
                                                    'etiqueta': nuevaEtiqueta,
                                                    'tarea': ''
                                                  });
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
                                icon: const Icon(Icons.edit),
                              ),
                              IconButton(
                                onPressed: () => tareaCubit.eliminarDato(index),
                                icon: const Icon(Icons.delete),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  ElevatedButton(
                      child: const Text('Crear Tarea'),
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
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
