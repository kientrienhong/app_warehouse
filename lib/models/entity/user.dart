import 'package:flutter/cupertino.dart';

enum UserRole { owner, customer }

class User with ChangeNotifier {
  String name;
  String email;
  String phone;
  String address;
  UserRole role;
  String jwtToken;

  User.empty() {
    name = '';
    email = '';
    phone = '';
    address = '';
    role = null;
    jwtToken = '';
  }

  User({User user}) {
    name = user.name;
    email = user.email;
    phone = user.phone;
    address = user.address;
    role = user.role;
    jwtToken = user.jwtToken;
    notifyListeners();
  }

  void setUser({User user}) {
    name = user.name;
    email = user.email;
    phone = user.phone;
    address = user.address;
    role = user.role;
    jwtToken = user.jwtToken;
    notifyListeners();
  }

  User.fromJson(Map<String, dynamic> json)
      : name = json['displayName'],
        email = json['email'],
        jwtToken = json['idToken'],
        address = 'address',
        phone = '077777777',
        role = UserRole.owner;
}
