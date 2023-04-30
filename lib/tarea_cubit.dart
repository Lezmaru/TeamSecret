import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:flutter/material.dart';

part 'tarea_state.dart';

class TareaCubit extends Cubit<TareaState> {
  List<String> _etiquetas = ['trabajo', 'estudio', 'personal'];
  TareaCubit() : super(TareaInitial()) {
    _loadData();
  }

  List<String> get etiquetas => _etiquetas;

  // Método para agregar una nueva etiqueta
  void agregarEtiqueta(String nuevaEtiqueta) {
    _etiquetas.add(nuevaEtiqueta);
  }

  // Método para eliminar una etiqueta
  void eliminarEtiqueta(String etiqueta) {
    _etiquetas.remove(etiqueta);
  }

  // Método para editar una etiqueta
  void editarEtiqueta(String viejaEtiqueta, String nuevaEtiqueta) {
    int index = _etiquetas.indexOf(viejaEtiqueta);
    if (index != -1) {
      _etiquetas[index] = nuevaEtiqueta;
    }
  }

  void _loadData() async {
    await Future.delayed(Duration(seconds: 2));
    emit(TareaLoaded([
      {'tarea': 'Ejemplo 1', 'etiqueta': 'trabajo'},
      {'tarea': 'Ejemplo 2', 'etiqueta': 'estudio'},
      {'tarea': 'Ejemplo 3', 'etiqueta': 'personal'},
    ]));
  }

  void agregarDato(Map<String, String> nuevoDato) {
    final datosActuales = List<Map<String, String>>.from(state.datosGuardados);
    datosActuales.add(nuevoDato);
    emit(TareaLoaded(datosActuales));
  }

  void editarDato(int indice, Map<String, String> nuevoDato) {
    final datosActuales = List<Map<String, String>>.from(state.datosGuardados);
    datosActuales[indice] = nuevoDato;
    emit(TareaLoaded(datosActuales));
  }

  void eliminarDato(int indice) {
    final datosActuales = List<Map<String, String>>.from(state.datosGuardados);
    datosActuales.removeAt(indice);
    emit(TareaLoaded(datosActuales));
  }

  void guardar(String nombreTarea, DateTime fechaTarea, String etiquetaTarea) {
    final datosActuales = List<Map<String, String>>.from(state.datosGuardados);
    Map<String, String> nuevaTarea = {
      'tarea': '$nombreTarea, $fechaTarea',
      'etiqueta': etiquetaTarea
    };
    datosActuales.add(nuevaTarea);
    emit(TareaLoaded(datosActuales));
  }

  // Método para eliminar la tarea
  void eliminar(int index) {
    final datosActuales = List<Map<String, String>>.from(state.datosGuardados);
    datosActuales.removeAt(index);
    emit(TareaLoaded(datosActuales));
  }

  // Método para editar la tarea
  void editar(int index, String nombre, DateTime fecha, String etiqueta) {
    final tarea = {'tarea': '$nombre, $fecha', 'etiqueta': etiqueta};
    final datosActuales = List<Map<String, String>>.from(state.datosGuardados);
    datosActuales[index] = tarea;
    emit(TareaLoaded(datosActuales));
  }
}
