import 'package:flutter/material.dart';

void main() => runApp(Etiquetas());

class Etiquetas extends StatefulWidget {
  static String id = 'etiquetas';
  const Etiquetas({Key? key}) : super(key: key);
  @override
  _EtiquetasState createState() => _EtiquetasState();
}

class _EtiquetasState extends State<Etiquetas> {
  List<String> _texts = [];

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
          return Scaffold(
            appBar: AppBar(title: const Text('Textos guardados')),
            body: Center(
              child: DropdownButton<String>(
                value: _texts.isNotEmpty ? _texts[0] : null,
                onChanged: (String? newValue) {},
                items: _texts
                    .map<DropdownMenuItem<String>>(
                        (String value) => DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            ))
                    .toList(),
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Textos',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Textos'),
        ),
        body: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Expanded(
                  child: TextField(
                    controller: _textController,
                    decoration: const InputDecoration(
                      hintText: 'Ingrese un texto',
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: _addText,
                  child: const Text('Agregar'),
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
          ],
        ),
      ),
    );
  }
}
