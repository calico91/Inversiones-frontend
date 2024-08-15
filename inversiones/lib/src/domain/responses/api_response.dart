import 'dart:convert';

import 'package:inversiones/src/domain/entities/user.dart';

ApiResponse<T> apiResponseFromJson<T>(
    String str, T Function(Map<String, dynamic>) fromJsonT) {
  return ApiResponse<T>.fromJson(
      json.decode(str) as Map<String, dynamic>, fromJsonT);
}

class ApiResponse<T> {
  const ApiResponse({
    required this.status,
    required this.message,
    this.data,
  });

  final int status;
  final String message;
  final T? data;

  factory ApiResponse.fromJson(
      Map<String, dynamic> json, T Function(Map<String, dynamic>) fromJsonT) {
    final int status = json['status'] as int;
    return ApiResponse<T>(
      status: status,
      message: json['message'] as String,
      data: status == 200
          ? fromJsonT(json['data'] as Map<String, dynamic>)
          : null,
    );
  }

  static ApiResponse<User> parseUserResponse(String responseBody) {
    return apiResponseFromJson<User>(responseBody, (dataJson) => User.fromJson(dataJson));
  }
}
