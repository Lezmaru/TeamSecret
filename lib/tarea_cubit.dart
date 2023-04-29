import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:flutter/material.dart';

part 'tarea_state.dart';

class TareaCubit extends Cubit<TareaState> {
  TareaCubit() : super(TareaInitial());

  void agregarDato(String nuevoDato) {
    final datosActuales = state.datosGuardados;
    datosActuales.add(nuevoDato);
    emit(TareaLoaded(datosActuales));
  }

  void editarDato(int indice, String nuevoDato) {
    final datosActuales = state.datosGuardados;
    datosActuales[indice] = nuevoDato;
    emit(TareaLoaded(datosActuales));
  }

  void eliminarDato(int indice) {
    final datosActuales = state.datosGuardados;
    datosActuales.removeAt(indice);
    emit(TareaLoaded(datosActuales));
  }

  // Método añadido
  void guardar(String nombreTarea, DateTime fechaTarea, String etiquetaTarea) {
    final datosActuales = state.datosGuardados;
    // Aquí puedes guardar tus datos de la forma que desees.
    // Este es solo un ejemplo de cómo podrías hacerlo.
    String nuevaTarea = '$nombreTarea, $fechaTarea, $etiquetaTarea';
    datosActuales.add(nuevaTarea);
    emit(TareaLoaded(datosActuales));
  }
}
