part of 'tarea_cubit.dart';

@immutable
abstract class TareaState {
  const TareaState();

  List<Map<String, String>> get datosGuardados => const [];
  List<String> get etiquetas => const [];

  List<Map<String, String>> get archivedTasks => const [];
}

class TareaInitial extends TareaState {}

class TareaLoaded extends TareaState {
  final List<Map<String, String>> datosGuardados;
  final List<Map<String, String>> archivedTasks;
  final List<String> etiquetas;

  TareaLoaded(this.datosGuardados,
      {required this.etiquetas, this.archivedTasks = const []});
}
