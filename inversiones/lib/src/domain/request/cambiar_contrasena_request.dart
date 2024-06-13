class CambiarContrasenaRequest {
  CambiarContrasenaRequest(
    this.idUsuario,
    this.contrasenaActual,
    this.contrasenaNueva,
  );
  int idUsuario;
  String contrasenaActual;
  String contrasenaNueva;

  Map<String, dynamic> toJson() {
    return {
      'id_usuario': idUsuario,
      'contrasena_actual': contrasenaActual,
      'contrasena_nueva': contrasenaNueva,
    };
  }
}
