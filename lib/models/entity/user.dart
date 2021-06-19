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
    role = UserRole.customer;
    jwtToken = '';
  }

  User(
      {String name,
      String email,
      String phone,
      String address,
      UserRole role,
      String jwtToken}) {
    this.name = name;
    this.email = email;
    this.phone = phone;
    this.address = address;
    this.jwtToken = jwtToken;
    this.role = role;
  }

  User.copyWith({
    String name,
    String email,
    String phone,
    String address,
    UserRole role,
    String jwtToken,
  }) {
    name = name;
    email = email;
    phone = phone;
    address = address;
    role = role;
    jwtToken = jwtToken;
  }

  void setUser({User user}) {
    name = user.name ?? this.name;
    email = user.email ?? this.email;
    phone = user.phone ?? this.phone;
    address = user.address ?? this.address;
    role = user.role ?? this.role;
    jwtToken = user.jwtToken ?? this.jwtToken;
    notifyListeners();
  }

  User copyWith({
    String name,
    String email,
    String phone,
    String address,
    UserRole role,
    String jwtToken,
  }) {
    return User(
        address: address ?? this.address,
        email: email ?? this.email,
        jwtToken: jwtToken ?? this.jwtToken,
        name: name ?? this.name,
        phone: phone ?? this.phone,
        role: role ?? this.role);
  }

  factory User.fromJson(Map<String, dynamic> json) {
    String roleString = json['roleName'];
    UserRole userRole =
        roleString == 'Owner' ? UserRole.owner : UserRole.customer;
    return User(
        address: 'address',
        email: 'email',
        jwtToken: json['idToken'],
        name: json['fullName'],
        phone: '0777777',
        role: userRole);
  }
}
