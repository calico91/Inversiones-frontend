import 'dart:convert';

GenericoResponse genericoResponseFromJson(String str) {
  return GenericoResponse.fromJson(json.decode(str) as Map<String, dynamic>);
}

class GenericoResponse {
  const GenericoResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  final int status;
  final String message;
  final String data;

  factory GenericoResponse.fromJson(Map<String, dynamic> json) =>
      GenericoResponse(
          status: json['status'] as int,
          message: json['message'] as String,
          data: json['data'] as String);
}
