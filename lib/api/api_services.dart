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
      throw Exception('Unathorized');
    }
  }

  static Future<dynamic> updateInfo(
      String name, String address, String phone, String jwt, String imageUrl) {
    try {
      return Dio().put('https://localhost:44318/api/v1/users/updateprofile',
          data: {
            'name': name,
            'address': address,
            'phone': phone,
            'avatarUrl': imageUrl
          },
          options: Options(headers: {
            'Authorization': 'bearer ' + jwt,
            'Content-Type': "application/json",
            'Accept': 'application/json',
          }));
    } catch (e) {
      throw Exception('Log in failed');
    }
  }

  static Future<dynamic> changePassword(
      String password, String oldPassword, String confirmPassword, String jwt) {
    try {
      return Dio().post('https://localhost:44318/api/v1/users/changepassword',
          data: {
            'oldPassword': oldPassword,
            'newPassword': password,
            'confirmPassword': confirmPassword
          },
          options: Options(headers: {
            'Authorization': 'bearer ' + jwt,
            'Content-Type': "application/json",
            'Accept': 'application/json',
          }));
    } catch (e) {
      throw Exception('Log in failed');
    }
  }

  static Future<dynamic> signUp(String role, String email, String password,
      String confirmPassword, String name, String phone, String address) {
    try {
      return Dio().post('https://localhost:44318/api/v1/users/signup', data: {
        "email": email,
        "password": password,
        "name": name,
        "address": address,
        "phone": phone,
        "roleName": role
      });
    } catch (e) {
      throw Exception('Log in failed');
    }
  }
}
