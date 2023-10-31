import 'dart:convert';

GenericoResponse genericoResponseFromJson(String str) =>
    GenericoResponse.fromJson(
      json.decode(str) as Map<String, dynamic>,
    );

class GenericoResponse {
  String message;
  int status;

  GenericoResponse({
    required this.message,
    required this.status,
  });

  factory GenericoResponse.fromJson(Map<String, dynamic> json) =>
      GenericoResponse(
        message: json["message"] as String,
        status: json["status"] as int,
      );
}
