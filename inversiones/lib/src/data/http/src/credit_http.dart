import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:inversiones/src/data/http/base_http_client.dart';
import 'package:inversiones/src/data/http/url_paths.dart';
import 'package:inversiones/src/domain/repositories/credit_repository.dart';
import 'package:inversiones/src/domain/request/add_credit_request.dart';
import 'package:inversiones/src/domain/request/pagar_cuota_request.dart';
import 'package:inversiones/src/domain/responses/creditos/abonos_realizados_response.dart';
import 'package:inversiones/src/domain/responses/creditos/add_credit_response.dart';
import 'package:inversiones/src/domain/responses/creditos/estado_credito_response.dart';
import 'package:inversiones/src/domain/responses/creditos/info_credito_saldo_response.dart';
import 'package:inversiones/src/domain/responses/creditos/info_creditos_activos_response.dart';
import 'package:inversiones/src/domain/responses/cuota_credito/pay_fee_response.dart';
import 'package:inversiones/src/domain/responses/generico_response.dart';

class CreditHttp implements CreditRepository {
  const CreditHttp({
    this.baseHttpClient = const BaseHttpClient(),
  });

  final BaseHttpClient baseHttpClient;

  @override
  Future<AddCreditResponse> addCredit(AddCreditRequest addCreditRequest) async {
    try {
      final http.Response response = await baseHttpClient
          .post(UrlPaths.addCredit, request: addCreditRequest.toJson());
      return compute(addCreditResponseFromJson, response.body);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<PayFeeResponse> infoPayFee(int idCliente, int idCredito) async {
    try {
      final http.Response response = await baseHttpClient
          .get('${UrlPaths.infoPayFee}/$idCliente/$idCredito');
      return compute(payFeeResponseFromJson, response.body);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<GenericoResponse> pagarCuota(
    PagarCuotaRequest pagarCuotaRequest,
  ) async {
    try {
      final http.Response response = await baseHttpClient.put(
        '${UrlPaths.pagarCuota}/${pagarCuotaRequest.idCuotaCredito}',
        request: pagarCuotaRequest.toJson(),
      );
      return compute(genericoResponseFromJson, response.body);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<InfoCreditosActivosResponse> infoCreditosActivos() async {
    try {
      final http.Response response =
          await baseHttpClient.get(UrlPaths.infoCreditosActivos);
      return compute(infoCreditosActivosResponseFromJson, response.body);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<InfoCreditoySaldoResponse> infoCreditoySaldo(int idCredito) async {
    try {
      final http.Response response =
          await baseHttpClient.get('${UrlPaths.infoCreditoySaldo}/$idCredito');

      return compute(infoCreditoySaldoResponseFromJson, response.body);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<PayFeeResponse> modificarFechaCuota(
    String fechaNueva,
    int idCredito,
  ) async {
    try {
      final http.Response response = await baseHttpClient.put(
        '${UrlPaths.modificarFechaCuota}/$fechaNueva/$idCredito',
      );
      return compute(payFeeResponseFromJson, response.body);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<EstadoCreditoResponse> modificarEstadoCredito(
    int idCredito,
    int estadoCredito,
  ) async {
    try {
      final http.Response response = await baseHttpClient.put(
        '${UrlPaths.modificarEstadoCredito}/$idCredito/$estadoCredito',
      );
      return compute(estadoCreditoResponseFromJson, response.body);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<AbonosRealizadosResponse> consultarAbonosRealizados(
    int idCredito,
  ) async {
    try {
      final http.Response response = await baseHttpClient
          .get('${UrlPaths.consultarAbonosRealizados}/$idCredito');
      return compute(abonosRealizadosResponseFromJson, response.body);
    } catch (e) {
      rethrow;
    }
  }
}
