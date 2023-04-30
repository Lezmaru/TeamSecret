part of 'tarea_cubit.dart';

@immutable
abstract class TareaState {
  const TareaState();

  List<Map<String, String>> get datosGuardados => const [];
}

class TareaInitial extends TareaState {}

class TareaLoaded extends TareaState {
  final List<Map<String, String>> datosCargados;

  const TareaLoaded(this.datosCargados);

  @override
  List<Map<String, String>> get datosGuardados => datosCargados;
}
