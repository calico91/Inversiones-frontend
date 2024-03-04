import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:inversiones/src/data/http/base_http_client.dart';
import 'package:inversiones/src/data/http/url_paths.dart';
import 'package:inversiones/src/domain/repositories/reportes_repository.dart';
import 'package:inversiones/src/domain/responses/creditos/abonos_realizados_response.dart';
import 'package:inversiones/src/domain/responses/reportes/reporte_interes_capital_response.dart';

class ReportesHttp implements ReportesRepository {
  const ReportesHttp({
    this.baseHttpClient = const BaseHttpClient(),
  });

  final BaseHttpClient baseHttpClient;

  @override
  Future<ReporteInteresyCapitalResponse> infoReporteInteresyCapital(
    String fechaInicial,
    String fechaFinal,
  ) async {
    try {
      final http.Response response = await baseHttpClient.get(
        UrlPaths.infoReporteInteresyCapital,
        {'fechaInicial': fechaInicial, 'fechaFinal': fechaFinal},
      );
      return compute(reporteInteresyCapitalResponseFromJson, response.body);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<AbonosRealizadosResponse> consultarUltimosAbonos(
    int cantidadAbonos,
  ) async {
    try {
      final http.Response response = await baseHttpClient.get(
        '${UrlPaths.consultarUltimosAbonos}/$cantidadAbonos',
      );
      return compute(abonosRealizadosResponseFromJson, response.body);
    } catch (_) {
      rethrow;
    }
  }
}
