import 'package:dio/dio.dart';

class ApiServices {
  ApiServices._();

  static Future<dynamic> logIn(String email, String password) {
    try {
      return Dio().post('https://localhost:44318/api/v1/users/login', data: {
        'email': email,
        'password': password,
        'returnSecureToken': true
      });
    } catch (e) {
      throw Exception('Log in failed');
    }
  }

  static Future<dynamic> loadListStorage(int page, int size, String jwt) {
    try {
      return Dio()
          .get('https://localhost:44318/api/v1/storages?page=$page&size=$size',
              options: Options(headers: {
                'Authorization': 'bearer ' + jwt,
                'Content-Type': "application/json",
                'Accept': 'application/json',
              }));
    } catch (e) {
      throw Exception('Log in failed');
    }
  }
}
