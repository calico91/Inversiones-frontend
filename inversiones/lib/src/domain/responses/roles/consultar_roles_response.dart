import 'dart:convert';

import 'package:inversiones/src/domain/entities/roles.dart';

RolesResponse consultarRolesResponseFromJson(String str) {
  return RolesResponse.fromJson(
      json.decode(str) as Map<String, dynamic>);
}

class RolesResponse {
  const RolesResponse({
    required this.status,
    required this.message,
    this.roles,
  });

  final int status;
  final String message;
  final List<Roles>? roles;

  factory RolesResponse.fromJson(Map<String, dynamic> json) {
    final int status = json['status'] as int;
    return RolesResponse(
      status: status,
      message: json['message'] as String,
      roles: status != 200
          ? List.empty()
          : List<Roles>.from((json['data'] as List<dynamic>).map((element) {
              return Roles.fromJson(element as Map<String, dynamic>);
            })),
    );
  }
}
