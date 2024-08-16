import 'dart:convert';

import 'package:inversiones/src/domain/entities/roles.dart';

User userFromJson(String str) {
  return User.fromJson(json.decode(str) as Map<String, dynamic>);
}

class User {
  const User({
    this.id,
    this.username,
    this.lastname,
    this.firstname,
    this.country,
    this.password,
    this.email,
    this.roles,
  });

  final int? id;
  final String? username;
  final String? lastname;
  final String? firstname;
  final String? country;
  final String? password;
  final String? email;
  final List<Roles>? roles;

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as int,
      username: json['username'] == null ? '' : json['username'] as String,
      lastname: json['lastname'] == null ? '' : json['lastname'] as String,
      firstname: json['firstname'] == null ? '' : json['firstname'] as String,
      country: json['country'] == null ? '' : json['country'] as String,
      password: json['password'] == null ? '' : json['password'] as String,
      email: json['email'] == null ? '' : json['email'] as String,
      roles: json['roles'] != null
          ? List<Roles>.from(
              (json['roles'] as List<dynamic>).map((element) {
                return Roles.fromJson(element as Map<String, dynamic>);
              }),
            )
          : [],
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
