import 'dart:convert';

import 'package:inversiones/src/domain/entities/client.dart';

AllClientsResponse allClientsResponseFromJson(String str) {
  return AllClientsResponse.fromJson(json.decode(str) as Map<String, dynamic>);
}

class AllClientsResponse {
  const AllClientsResponse({
    required this.status,
    required this.message,
    this.clients,
  });

  final int status;
  final String message;
  final List<Client>? clients;

  factory AllClientsResponse.fromJson(Map<String, dynamic> json) {
    final int status = json['status'] as int;
    return AllClientsResponse(
      status: status,
      message: json['message'] as String,
      clients: status != 200
          ? List.empty()
          : List<Client>.from(
              (json['data'] as List<dynamic>).map((element) {
                return Client.fromJson(element as Map<String, dynamic>);
              }),
            ),
    );
  }
}
