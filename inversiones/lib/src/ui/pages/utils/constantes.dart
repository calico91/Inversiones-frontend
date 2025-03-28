class Constantes {
  const Constantes();
  static String SOLO_INTERES = 'SI';
  static String ABONO_CAPITAL = 'AC';
  static String CUOTA_NORMAL = 'CN';
  static String CREDITO_ACTIVO = 'A';
  static String CREDITO_ANULADO = 'N';
  static String CREDITO_PAGADO = 'C';
  static String INFORMACION_CREDITO_CREADO(int dias, String valor) =>
      'Se aplicara mora por cada $dias días pasados de la fecha de la cuota, valor adicional: $valor';
  static String INFORMACION_CREDITO = 'Informacion crédito';
  static int CODIGO_MODALIDAD_MENSUAL = 1;
  static int CODIGO_MODALIDAD_QUINCENAL = 2;
  static String MODALIDAD_MENSUAL = 'Mensual';
  static String MODALIDAD_QUINCENAL = 'Quincenal';
  static int CODIGO_CREDITO_ACTIVO = 1;
  static int CODIGO_CREDITO_ANULADO = 3;
  static int CODIGO_CREDITO_PAGADO = 2;
  static String NO_TOKEN = 'Bearer notoken';
  static String CARGANDO = 'assets/cargando-ondas.json';
  static String ERROR_INTERNET_SERVIDOR =
      'Verifique la conexion a internet o configuracion de su servidor';
  static String CREDITO_SALDADO = 'Crédito saldado';
}
