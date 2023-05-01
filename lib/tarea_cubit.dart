import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:flutter/material.dart';

part 'tarea_state.dart';

class TareaCubit extends Cubit<TareaState> {
  List<String>? _etiquetas;

  TareaCubit() : super(TareaInitial()) {
    _etiquetas = crearEtiquetasIniciales();
    _loadData();
  }

  static List<String> crearEtiquetasIniciales() {
    return ['trabajo', 'estudio', 'personal'];
  }

  List<String> get etiquetas => _etiquetas!;

  void agregarEtiqueta(String nuevaEtiqueta) {
    _etiquetas!.add(nuevaEtiqueta);
    emit(TareaLoaded(state.datosGuardados, etiquetas: _etiquetas!));
  }

  void eliminarEtiqueta(String etiqueta) {
    _etiquetas!.remove(etiqueta);
    emit(TareaLoaded(state.datosGuardados, etiquetas: _etiquetas!));
  }

  void editarEtiqueta(String viejaEtiqueta, String nuevaEtiqueta) {
    int index = _etiquetas!.indexOf(viejaEtiqueta);
    if (index != -1) {
      _etiquetas![index] = nuevaEtiqueta;
      emit(TareaLoaded(state.datosGuardados, etiquetas: _etiquetas!));
    }
  }

  void _loadData() async {
    await Future.delayed(Duration(seconds: 2));
    emit(TareaLoaded([
      {'tarea': 'Ejemplo 1', 'etiqueta': 'trabajo', 'estado': 'Pendiente'},
      {'tarea': 'Ejemplo 2', 'etiqueta': 'estudio', 'estado': 'Pendiente'},
      {'tarea': 'Ejemplo 3', 'etiqueta': 'personal', 'estado': 'Pendiente'},
    ], etiquetas: _etiquetas!));
  }

  void agregarDato(Map<String, String> nuevoDato) {
    final datosActuales = List<Map<String, String>>.from(state.datosGuardados);
    datosActuales.add(nuevoDato);
    emit(TareaLoaded(datosActuales, etiquetas: _etiquetas!));
  }

  void editarDato(int indice, Map<String, String> nuevoDato) {
    final datosActuales = List<Map<String, String>>.from(state.datosGuardados);
    datosActuales[indice] = nuevoDato;
    emit(TareaLoaded(datosActuales, etiquetas: _etiquetas!));
  }

  void eliminarDato(int indice) {
    final datosActuales = List<Map<String, String>>.from(state.datosGuardados);
    datosActuales.removeAt(indice);
    emit(TareaLoaded(datosActuales, etiquetas: _etiquetas!));
  }

  void guardar(String nombreTarea, DateTime fechaTarea, String etiquetaTarea) {
    final datosActuales = List<Map<String, String>>.from(state.datosGuardados);
    Map<String, String> nuevaTarea = {
      'tarea': '$nombreTarea, $fechaTarea',
      'etiqueta': etiquetaTarea,
      'estado': 'Pendiente'
    };
    datosActuales.add(nuevaTarea);
    emit(TareaLoaded(datosActuales, etiquetas: []));
  }

  void eliminar(int index) {
    final datosActuales = List<Map<String, String>>.from(state.datosGuardados);
    datosActuales.removeAt(index);
    emit(TareaLoaded(datosActuales, etiquetas: _etiquetas!));
  }

  void editar(int index, String nombre, DateTime fecha, String etiqueta) {
    final tarea = {'tarea': '$nombre, $fecha', 'etiqueta': etiqueta};
    final datosActuales = List<Map<String, String>>.from(state.datosGuardados);
    datosActuales[index] = tarea;
    emit(TareaLoaded(datosActuales, etiquetas: _etiquetas!));
  }

  void archivarDato(int index) {
    final datosGuardados = List<Map<String, String>>.from(state.datosGuardados);
    final datosArchivados = List<Map<String, String>>.from(state.archivedTasks);
    final tareaArchivada = datosGuardados.removeAt(index);
    datosArchivados.add(tareaArchivada);
    emit(TareaLoaded(datosGuardados,
        etiquetas: _etiquetas!, archivedTasks: datosArchivados));
  }

  void eliminarDatoArchivado(int index) {
    final newArchived = List<Map<String, String>>.from(state.archivedTasks);
    newArchived.removeAt(index);
    emit(TareaLoaded(state.datosGuardados,
        etiquetas: _etiquetas!, archivedTasks: newArchived));
  }
}
