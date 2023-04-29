import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tslfpc/tarea_cubit.dart';
import 'crear.dart';

void main() => runApp(
      BlocProvider(
        create: (context) => TareaCubit(),
        child: Etiquetas(
          agregarDato: (dato) {}, // Función temporal
          editarDato: (dato) {}, // Función temporal
          eliminarDato: (dato) {}, // Función temporal
          datosGuardados: const [],
        ),
      ),
    );

class Etiquetas extends StatefulWidget {
  final List<String> datosGuardados;
  final Function agregarDato;
  final Function editarDato;
  final Function eliminarDato;

  Etiquetas({
    Key? key,
    required this.datosGuardados,
    required this.agregarDato,
    required this.editarDato,
    required this.eliminarDato,
  }) : super(key: key);

  @override
  _EtiquetasState createState() => _EtiquetasState();
}

class _EtiquetasState extends State<Etiquetas> {
  final TextEditingController _textController = TextEditingController();

  void _addText(BuildContext context) {
    context.read<TareaCubit>().agregarDato(_textController.text);
    _textController.clear();
  }

  void _deleteText(int index, BuildContext context) {
    context.read<TareaCubit>().eliminarDato(index);
  }

  void _saveTexts(BuildContext context) {
    // Aquí, asumimos que guardas los datos de alguna manera.
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Etiquetas',
        home: BlocBuilder<TareaCubit, TareaState>(
          builder: (context, state) {
            return Scaffold(
              appBar: AppBar(
                backgroundColor: Color.fromARGB(255, 0, 0, 0),
                title: const Text('Etiquetas',
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold)),
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
                                    controller: _textController,
                                    decoration: const InputDecoration(
                                      hintText: 'Ingrese una etiqueta',
                                    ),
                                  ),
                                ),
                              ],
                            )),
                        ElevatedButton(
                          onPressed: () => _addText(context),
                          child: const Text('Agregar',
                              selectionColor: Color.fromARGB(255, 0, 0, 0)),
                        ),
                      ],
                    ),
                    const Divider(),
                    Expanded(
                      child: ListView.builder(
                        itemCount: state.datosGuardados.length,
                        itemBuilder: (BuildContext context, int index) {
                          return ListTile(
                            title: Text(state.datosGuardados[index]),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                IconButton(
                                  onPressed: () {
                                    // Aquí, podrías mostrar un diálogo para editar el texto.
                                  },
                                  icon: const Icon(Icons.edit),
                                ),
                                IconButton(
                                  onPressed: () => _deleteText(index, context),
                                  icon: const Icon(Icons.delete),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () => _saveTexts(context),
                      child: const Text('Guardar textos'),
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    ElevatedButton(
                        child: const Text('Cancelar'),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) {
                              return Crear();
                            }),
                          );
                        }),
                  ],
                ),
              ),
            );
          },
        ));
  }
}
