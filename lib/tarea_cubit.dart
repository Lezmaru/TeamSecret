import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:flutter/material.dart';

part 'tarea_state.dart';

class TareaCubit extends Cubit<TareaState> {
  TareaCubit() : super(TareaInitial()) {
    _loadData();
  }

  void _loadData() async {
    await Future.delayed(Duration(seconds: 2));
    emit(TareaLoaded(['trabajo', 'estudio', 'personal']));
  }

  void agregarDato(String nuevoDato) {
    final datosActuales = List.of(state.datosGuardados);
    datosActuales.add(nuevoDato);
    emit(TareaLoaded(datosActuales));
  }

  void editarDato(int indice, String nuevoDato) {
    final datosActuales = List.of(state.datosGuardados);
    datosActuales[indice] = nuevoDato;
    emit(TareaLoaded(datosActuales));
  }

  void eliminarDato(int indice) {
    final datosActuales = List.of(state.datosGuardados);
    datosActuales.removeAt(indice);
    emit(TareaLoaded(datosActuales));
  }

  void guardar(String nombreTarea, DateTime fechaTarea, String etiquetaTarea) {
    final datosActuales = List.of(state.datosGuardados);
    String nuevaTarea = '$nombreTarea, $fechaTarea, $etiquetaTarea';
    datosActuales.add(nuevaTarea);
    emit(TareaLoaded(datosActuales));
  }
}
