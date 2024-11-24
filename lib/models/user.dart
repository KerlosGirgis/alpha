import 'address.dart';

class User {
  String token;
  String name;
  String email;
  Address address;

  User(
      {
        required this.name,
        required this.token,
        required this.email,
        required this.address,
        });

  Map<String, dynamic> toMap() {
    return {
      'token': token,
      'name': name,
      'email': email,
      'address': address,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      token: map['token'],
      name: map['name'],
      email: map['email'],
      address: map['address'],
    );
  }

}