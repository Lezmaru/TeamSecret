import 'package:flutter/material.dart';

import 'crear.dart';

void main() => runApp(Etiquetas(
      agregarDato: (String nuevoDato) {},
      datosGuardados: [],
      editarDato: (int indice, String nuevoDato) {},
      eliminarDato: (int indice) {},
    ));

class Etiquetas extends StatefulWidget {
  static String id = 'etiquetas';
  const Etiquetas(
      {Key? key,
      required List<String> datosGuardados,
      required void Function(String nuevoDato) agregarDato,
      required void Function(int indice, String nuevoDato) editarDato,
      required void Function(int indice) eliminarDato})
      : super(key: key);
  @override
  _EtiquetasState createState() => _EtiquetasState();
}

class _EtiquetasState extends State<Etiquetas> {
  List<String> _texts = [];
  List<String> _datosGuardados = ["Trabajo", "Estudio", "Personal"];
  final TextEditingController _textController = TextEditingController();

  void _addText() {
    setState(() {
      _texts.add(_textController.text);
      _textController.clear();
    });
  }

  void _editText(int index) async {
    final String? result = await showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        final TextEditingController _editTextController =
            TextEditingController(text: _texts[index]);
        return AlertDialog(
          title: const Text('Editar texto'),
          content: TextField(
            controller: _editTextController,
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  _texts[index] = _editTextController.text;
                });
                Navigator.pop(context, _editTextController.text);
              },
              child: const Text('Guardar'),
            ),
          ],
        );
      },
    );

    if (result != null) {
      setState(() {
        _texts[index] = result;
      });
    }
  }

  void _deleteText(int index) {
    setState(() {
      _texts.removeAt(index);
    });
  }

  void _saveTexts() {
    Navigator.push(
      context,
      MaterialPageRoute<void>(
        builder: (BuildContext context) {
          return Crear(
            datosGuardados: _texts,
            agregarDato: (String nuevoDato) {
              setState(() {
                _texts.add(nuevoDato);
              });
            },
            editarDato: (int indice, String nuevoDato) {
              setState(() {
                _texts[indice] = nuevoDato;
              });
            },
            eliminarDato: (int indice) {},
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Etiquetas',
        home: Scaffold(
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
                      onPressed: _addText,
                      child: const Text('Agregar',
                          selectionColor: Color.fromARGB(255, 0, 0, 0)),
                    ),
                  ],
                ),
                const Divider(),
                Expanded(
                  child: ListView.builder(
                    itemCount: _texts.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(
                        title: Text(_texts[index]),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            IconButton(
                              onPressed: () => _editText(index),
                              icon: const Icon(Icons.edit),
                            ),
                            IconButton(
                              onPressed: () => _deleteText(index),
                              icon: const Icon(Icons.delete),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                ElevatedButton(
                  onPressed: _saveTexts,
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
                          return Crear(
                            datosGuardados: _datosGuardados,
                            agregarDato: (String nuevoDato) {
                              setState(() {
                                _datosGuardados.add(nuevoDato);
                              });
                            },
                            editarDato: (int indice, String nuevoDato) {
                              setState(() {
                                _datosGuardados[indice] = nuevoDato;
                              });
                            },
                            eliminarDato: (int indice) {},
                          );
                        }),
                      );
                    }),
              ],
            ),
          ),
        ));
  }
}
