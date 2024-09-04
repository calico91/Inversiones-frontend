import 'dart:convert';

import 'package:inversiones/src/domain/entities/user_details.dart';

UserDetailsResponse userdetailsResponseFromJson(String str) {
  return UserDetailsResponse.fromJson(json.decode(str) as Map<String, dynamic>);
}

class UserDetailsResponse {
  const UserDetailsResponse({
    required this.status,
    required this.message,
    this.userDetails,
  });

  final int status;
  final String message;
  final UserDetails? userDetails;

  factory UserDetailsResponse.fromJson(Map<String, dynamic> json) {
    final int status = json['status'] as int;
    return UserDetailsResponse(
      status: status,
      message: json['message'] as String,
      userDetails: status == 200
          ? UserDetails.fromJson(json['data'] as Map<String, dynamic>)
          : null,
    );
  }
}
