import 'package:inversiones/src/domain/entities/roles.dart';

class User {
  const User({
    this.id,
    required this.username,
    required this.lastname,
    required this.firstname,
    required this.country,
    required this.password,
    required this.email,
    required this.roles,
  });

  final int? id;
  final String username;
  final String lastname;
  final String firstname;
  final String country;
  final String password;
  final String email;
  final List<Roles> roles;

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as int,
      username: json['username'] as String,
      lastname: json['lastname'] as String,
      firstname: json['firstname'] as String,
      country: json['country'] as String,
      password: json['password'] as String,
      email: json['email'] as String,
      roles: List<Roles>.from(
        (json['roles'] as List<dynamic>).map((element) {
          return Roles.fromJson(element as Map<String, dynamic>);
        }),
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (id != 0) 'id': id,
      'username': username,
      'lastname': lastname,
      'firstname': firstname,
      'country': country,
      'password': password,
      'email': email,
      'roles': roles,
    };
  }
}
