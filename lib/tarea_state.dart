part of 'tarea_cubit.dart';

@immutable
abstract class TareaState {
  const TareaState();

  List<String> get datosGuardados => const [];
}

class TareaInitial extends TareaState {}

class TareaLoaded extends TareaState {
  final List<String> datosCargados;

  const TareaLoaded(this.datosCargados);

  @override
  List<String> get datosGuardados => datosCargados;
}
