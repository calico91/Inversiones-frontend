import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:inversiones/src/data/http/base_http_client.dart';
import 'package:inversiones/src/data/http/url_paths.dart';
import 'package:inversiones/src/domain/repositories/credit_repository.dart';
import 'package:inversiones/src/domain/request/add_credit_request.dart';
import 'package:inversiones/src/domain/responses/add_credit_response.dart';
import 'package:inversiones/src/domain/responses/pay_fee_response.dart';

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
  Future<PayFeeResponse> infoPayFee(int idCliente) async {
    try {
      final http.Response response =
          await baseHttpClient.get('${UrlPaths.infoPayFee}/$idCliente');
      return compute(payFeeResponseFromJson, response.body);
    } catch (e) {
      rethrow;
    }
  }
}
