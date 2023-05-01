import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tslfpc/tarea_cubit.dart';

class Archivados extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TareaCubit, TareaState>(
      builder: (context, state) {
        final tareaCubit = BlocProvider.of<TareaCubit>(context);
        final tareasArchivadas = state.archivedTasks;

        return Scaffold(
          appBar: AppBar(
            title: Text('Tareas Archivadas'),
            centerTitle: true,
            backgroundColor: Colors.black,
          ),
          body: tareasArchivadas.isEmpty
              ? Center(
                  child: Text('No hay tareas archivadas.'),
                )
              : ListView.builder(
                  itemCount: tareasArchivadas.length,
                  itemBuilder: (context, index) {
                    return Card(
                      child: ListTile(
                        title: Text(
                          tareasArchivadas[index]['tarea'] ??
                              'Valor predeterminado',
                          style: TextStyle(
                            fontSize: 24.0,
                          ),
                        ),
                        subtitle: Text(
                          'Etiqueta: ${tareasArchivadas[index]['etiqueta'] ?? 'Ninguna'}',
                          style: TextStyle(
                            fontSize: 18.0,
                          ),
                        ),
                        trailing: IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () {
                            tareaCubit.eliminarDatoArchivado(index);
                          },
                        ),
                      ),
                    );
                  },
                ),
        );
      },
    );
  }
}
