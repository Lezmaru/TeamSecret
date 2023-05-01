// ignore: file_names
import 'dart:convert';
import 'package:tslfpc/services/ip/ip.dart' as ip;
import 'package:http/http.dart' as http;

import '../Dto/LoginResponseDto.dart';
import '../dto/ResponseDto.dart';

class LoginService {
  static String backendUrlBase = ip.urlBack;
  //Creamos el future para que nos devuelva un LoginResponseDto
  static Future<LoginResponseDto> login(
      String username, String password) async {
    // guardaremos la respuesta en la variable result
    LoginResponseDto result;
    //guardamos en variables lo necesario para hacer el post
    var uri = Uri.parse("$backendUrlBase/api/v1/auth/login");
    var body = jsonEncode({
      'username': username,
      'password': password,
    });
    // Como es Java es obligatorio mandar Content-Type y Accept
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };
    // Realizamos la invocación por post al Backend con los datos proporcionados.
    var response = await http.post(uri, headers: headers, body: body);
    print('Respuesta del backend: ${response.body}');
    // Pregunto si el backend dió exitosa la solicitud
    if (response.statusCode == 200) {
      print('Respuesta 200 del backend.');
      // 200 significa que el backend proceso la solicitud.
      // Decodifficamos el JSON a un objecto responseDto y guardamos todo el cuerpo  del ResponseDto
      var responseDto = ResponseDto.fromJson(jsonDecode(response.body));
      print('responseDto después de la deserialización: $responseDto');
      // Pregunto si el backend autentico al usuario
      if (responseDto.code.toString() == '0000') {
        // Decodificamos el data del objecto Response del backend y lo covertimos
        // a una clase Dart para retornarselo al CUBIT
        result = LoginResponseDto.fromJson(responseDto.response);
        print('result: $result');
      } else {
        // Si el backend envíe error (success = true), entonces seguramente
        // envió un message para mostrarle a nuestra usuario final
        throw Exception(responseDto.errorMessage);
      }
    } else {
      print('Error de estado del backend: ${response.statusCode}');
      throw Exception('Failed to login.');
    }
    return result;
  }
}
