import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:tslfpc/menu.dart';
import 'package:tslfpc/services/login_services.dart';
import 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  Future<void> logIn(String username, String password) async {
    emit(LoginLoading());
    try {
      var loginResponse = await LoginService.login(username, password);
      if (loginResponse != null) {
        emit(LoginSuccess());
        MaterialPageRoute(builder: (context) => Menu());
      } else {
        emit(LoginFailure(
            error: 'Fallo en el inicio de sesión. Intenta de nuevo.'));
      }
    } catch (e) {
      emit(LoginFailure(error: e.toString()));
    }
  }
}
