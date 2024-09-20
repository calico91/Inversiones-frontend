import 'dart:convert';
import 'package:inversiones/src/domain/entities/permiso.dart';
import 'package:inversiones/src/domain/entities/roles.dart';
import 'package:inversiones/src/domain/entities/user.dart';
import 'package:inversiones/src/domain/responses/creditos/saldar_credito_response.dart';

ApiResponse<T> apiResponseFromJson<T>(
    String str, T Function(dynamic) fromJsonT) {
  return ApiResponse<T>.fromJson(
      json.decode(str) as Map<String, dynamic>, fromJsonT);
}

class ApiResponse<T> {
  const ApiResponse({required this.status, required this.message, this.data});

  final int status;
  final String message;
  final T? data;

  factory ApiResponse.fromJson(
      Map<String, dynamic> json, T Function(dynamic) fromJsonT) {
    final int status = json['status'] as int;
    return ApiResponse<T>(
        status: status,
        message: json['message'] as String,
        data: status == 200 ? fromJsonT(json['data']) : null);
  }

  // Método para parsear una respuesta que contiene un solo User
  static ApiResponse<User> parseUserResponse(String responseBody) {
    return apiResponseFromJson<User>(responseBody, (dataJson) {
      dataJson as Map<String, dynamic>;
      return User.fromJson(dataJson);
    });
  }

  // Método para parsear una respuesta que contiene una lista de User
  static ApiResponse<List<User>> parseUserListResponse(String responseBody) {
    return apiResponseFromJson<List<User>>(responseBody, (dataJson) {
      dataJson as List;
      return dataJson
          .map((json) => User.fromJson(json as Map<String, dynamic>))
          .toList();
    });
  }

  static ApiResponse<String> parseStringResponse(String responseBody) {
    return apiResponseFromJson<String>(responseBody, (dataJson) {
      return dataJson as String;
    });
  }

  static ApiResponse<SaldarCreditoResponse> parseSaldarCreditoResponse(
      String responseBody) {
    return apiResponseFromJson<SaldarCreditoResponse>(responseBody, (dataJson) {
      dataJson as Map<String, dynamic>;
      return SaldarCreditoResponse.fromJson(dataJson);
    });
  }

  static ApiResponse<Roles> parseRoles(String responseBody) {
    return apiResponseFromJson<Roles>(responseBody, (dataJson) {
      dataJson as Map<String, dynamic>;
      return Roles.fromJson(dataJson);
    });
  }

  static ApiResponse<List<Permiso>> parsePermisoListResponse(
      String responseBody) {
    return apiResponseFromJson<List<Permiso>>(responseBody, (dataJson) {
      dataJson as List;
      return dataJson
          .map((json) => Permiso.fromJson(json as Map<String, dynamic>))
          .toList();
    });
  }
}
