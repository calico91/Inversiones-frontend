class ImagenesClienteResponse {
  List<ImagenCliente>? imagenes;
  String message;
  int status;

  ImagenesClienteResponse.ImagenClienteResponse(
      {this.imagenes, required this.message, required this.status});

  factory ImagenesClienteResponse.fromJson(Map<String, dynamic> json) {
    return ImagenesClienteResponse.ImagenClienteResponse(
      imagenes: List<ImagenCliente>.from((json['data'] as List<dynamic>).map(
        (element) => ImagenCliente.fromJson(element as Map<String, dynamic>),
      )),
      message: json["message"] as String,
      status: json["status"] as int,
    );
  }
}

class ImagenCliente {
  String? base64;
  String extension;

  ImagenCliente({required this.base64, required this.extension});

  factory ImagenCliente.fromJson(Map<String, dynamic> json) => ImagenCliente(
      base64: json["base64"] as String, extension: json["extension"] as String);
}
