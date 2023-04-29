part of 'tarea_cubit.dart';

@immutable
abstract class TareaState {
  const TareaState();

  List<String> get datosGuardados => const [];
}

class TareaInitial extends TareaState {}

class TareaLoaded extends TareaState {
  final List<String> datosGuardados;

  const TareaLoaded(this.datosGuardados);

  @override
  List<String> get post => datosGuardados;
}
