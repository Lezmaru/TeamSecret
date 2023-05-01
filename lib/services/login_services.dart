// ignore: file_names
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../Dto/LoginResponseDto.dart';
import '../dto/ResponseDto.dart';

class LoginService {
  static String urlBack = "http://192.168.42.142:9999";
  static String backendUrlBase = urlBack;
  static Future<LoginResponseDto> login(
      String username, String password) async {
    LoginResponseDto result;
    var uri = Uri.parse("$backendUrlBase/api/v1/auth/login");
    var body = jsonEncode({
      'username': username,
      'password': password,
    });
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };
    var response = await http.post(uri, headers: headers, body: body);
    print('Respuesta del backend: ${response.body}');
    if (response.statusCode == 200) {
      print('Respuesta 200 del backend.');
      var responseDto = ResponseDto.fromJson(jsonDecode(response.body));
      print('responseDto después de la deserialización: $responseDto');
      if (responseDto.code.toString() == '0000') {
        result = LoginResponseDto.fromJson(responseDto.response);
        print('result: $result');
      } else {
        throw Exception(responseDto.errorMessage);
      }
    } else {
      print('Error de estado del backend: ${response.statusCode}');
      throw Exception('Failed to login.');
    }
    return result;
  }
}
