import 'package:inversiones/src/domain/request/add_credit_request.dart';
import 'package:inversiones/src/domain/responses/add_credit_response.dart';

abstract class CreditRepository {
  const CreditRepository();

  Future<AddCreditResponse> addCredit(AddCreditRequest addCreditRequest);
}
