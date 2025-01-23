class UrlPaths {
  const UrlPaths._();
  //static const String url = 'inversiones.up.railway.app';

  ///auth
  static const String authBiometrica = '/autenticacion/auth-biometrica';
  static const String vincularDispositivo =
      '/autenticacion/vincular-dispositivo';
  static const String signIn = '/autenticacion/login';

  ///cliente
  static const String allClients = '/cliente/consultar-clientes';
  static const String loadClient = '/cliente/consultar-cliente-por-cedula';
  static const String addClient = '/cliente/registrar-cliente';
  static const String updateClient = '/cliente/actualizar-cliente';
  static const String consultarCuotasPorFecha =
      '/cliente/consultar-cuotas-por-fecha';
  static const String consultarImagenes =
      '/imagenes-cliente/consultar-imagenes-por-id-cliente';
  static const String consultarClienteImagenes =
      '/cliente/consultar-cliente-por-id-imagenes';

  /// credito
  static const String addCredit = '/credito/registrar-renovar-credito';
  static const String infoCreditosActivos =
      '/credito/consultar-creditos-activos';
  static const String modificarEstadoCredito =
      '/credito/modificar-estado-credito';
  static const String saldarCredito = '/credito/saldar';

  ///cuota
  static const String pagarCuota = '/cuotaCredito/pagar-cuota';
  static const String infoPayFee = '/cuotaCredito/consultar-cuota-cliente';
  static const String infoCreditoySaldo =
      '/cuotaCredito/consultar-credito-saldo';
  static const String modificarFechaCuota =
      '/cuotaCredito/modificar-fecha-pago';
  static const String consultarAbonosRealizados =
      '/cuotaCredito/consultar-abonos-realizados';
  static const String consultarAbonoPorId =
      '/cuotaCredito/consultar-abono-por-id';
  static const String anularUltimoAbono = '/cuotaCredito/anular-ultimo-abono';

  ///reportes
  static const String reporteInteresyCapital =
      '/reporte/generar-reporte-interes-capital';
  static const String generarUltimosAbonosRealizados =
      '/reporte/generar-reporte-ultimos-abonos-realizados';

  ///user
  static const String cambiarContrasena = '/user/cambiar-contrasena';
  static const String registrarUsuario = '/user/registrar';
  static const String consultarUsuarios = '/user/consultar-usuarios';
  static const String consultarUsuario = '/user/consultar-usuario';
  static const String actualizarUsuario = '/user/actualizar';
  static const String cambiarEstado = '/user/cambiar-estado';
  static const String reiniciarContrasena = '/user/reiniciar-contrasena';

  ///roles
  static const String consultarRoles = '/roles/consultar-roles';
  static const String consultarPermisosRol = '/roles/consultar-permisos-rol';
  static const String consultarPermisos = '/permisos/consultar-todos';
  static const String asignarPermisos = '/roles/asignar-permisos';
}
