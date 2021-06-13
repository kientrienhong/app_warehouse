import 'package:dio/dio.dart';

class ApiServices {
  ApiServices._();

  static Future<dynamic> logIn(String email, String password) {
    try {
      return Dio().post('https://localhost:44318/api/v1/users/login',
          data: {'email': email, 'password': password});
    } catch (e) {
      throw Exception('Log in failed');
    }
  }
}
