import 'dart:convert';
import 'package:inversiones/src/domain/entities/user_details.dart';

SignInResponse signInResponseFromJson(String str) {
  return SignInResponse.fromJson(json.decode(str) as Map<String, dynamic>);
}

class SignInResponse {
  const SignInResponse({
    required this.status,
    required this.message,
    this.userDetails,
    this.token,
  });

  final int status;
  final String message;
  final UserDetails? userDetails;
  final String? token;

  factory SignInResponse.fromJson(Map<String, dynamic> json) {
    final int status = json['status'] as int;
    return SignInResponse(
      status: status,
      message: json['message'] as String,
      userDetails: status == 200
          ? UserDetails.fromJson(json['userDetails'] as Map<String, dynamic>)
          : null,
      token: status == 200 ? json['token'] as String : null,
    );
  }
}
