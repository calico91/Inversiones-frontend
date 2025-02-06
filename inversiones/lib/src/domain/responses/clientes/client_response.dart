import 'dart:convert';

import 'package:inversiones/src/domain/entities/client.dart';

ClientResponse addClientResponseFromJson(String str) {
  return ClientResponse.fromJson(json.decode(str) as Map<String, dynamic>);
}

class ClientResponse {
  const ClientResponse({
    required this.status,
    required this.message,
    this.client,
  });

  final int status;
  final String message;
  final Client? client;

  factory ClientResponse.fromJson(Map<String, dynamic> json) {
    final int status = json['status'] as int;
    return ClientResponse(
      status: status,
      message: json['message'] as String,
      client: status == 200
          ? Client.fromJson(json['data'] as Map<String, dynamic>)
          : null,
    );
  }
}
