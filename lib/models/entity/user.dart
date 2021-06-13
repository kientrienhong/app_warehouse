enum UserRole { owner, customer }

class User {
  final String name;
  final String email;
  final String phone;
  final String address;
  final UserRole role;
  final String jwtToken;

  User(
      {this.name,
      this.email,
      this.address,
      this.jwtToken,
      this.phone,
      this.role});

  User copyWith({
    String name,
    String email,
    String phone,
    String address,
    UserRole role,
    String jwtToken,
  }) {
    return User(
        address: address,
        email: email,
        jwtToken: jwtToken,
        name: name,
        phone: phone,
        role: role);
  }

  User.fromJson(Map<String, dynamic> json)
      : name = json['displayName'],
        email = json['email'],
        jwtToken = json['idToken'],
        address = 'address',
        phone = '077777777',
        role = UserRole.customer;
}
