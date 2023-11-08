import 'dart:convert';

import 'package:inversiones/src/domain/entities/client.dart';

AddClientResponse addClientResponseFromJson(String str) {
  return AddClientResponse.fromJson(json.decode(str) as Map<String, dynamic>);
}

class AddClientResponse {
  const AddClientResponse({
    required this.status,
    required this.message,
    this.client,
  });

  final int status;
  final String message;
  final Client? client;

  factory AddClientResponse.fromJson(Map<String, dynamic> json) {
    final int status = json['status'] as int;
    return AddClientResponse(
      status: status,
      message: json['message'] as String,
      client: status == 200
          ? Client.fromJson(json['data'] as Map<String, dynamic>)
          : null,
    );
  }
}
