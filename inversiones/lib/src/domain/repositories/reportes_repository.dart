import 'package:inversiones/src/domain/responses/creditos/abonos_realizados_response.dart';
import 'package:inversiones/src/domain/responses/reportes/reporte_interes_capital_response.dart';

abstract class ReportesRepository {
  const ReportesRepository();

  Future<ReporteInteresyCapitalResponse> infoReporteInteresyCapital(
    String fechaInicial,
    String fechaFinal,
  );
  Future<AbonosRealizadosResponse> consultarUltimosAbonos(
    int cantidadAbonos,
  );
}
