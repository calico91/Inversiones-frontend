import 'package:inversiones/src/domain/request/add_credit_request.dart';
import 'package:inversiones/src/domain/request/pagar_cuota_request.dart';
import 'package:inversiones/src/domain/responses/creditos/abonos_realizados_response.dart';
import 'package:inversiones/src/domain/responses/creditos/add_credit_response.dart';
import 'package:inversiones/src/domain/responses/creditos/estado_credito_response.dart';
import 'package:inversiones/src/domain/responses/creditos/info_credito_saldo_response.dart';
import 'package:inversiones/src/domain/responses/creditos/info_creditos_activos_response.dart';
import 'package:inversiones/src/domain/responses/cuota_credito/pay_fee_response.dart';
import 'package:inversiones/src/domain/responses/generico_response.dart';

abstract class CreditRepository {
  const CreditRepository();

  Future<AddCreditResponse> addCredit(AddCreditRequest addCreditRequest);
  Future<PayFeeResponse> infoPayFee(int idCliente, int idCredito);
  Future<GenericoResponse> pagarCuota(PagarCuotaRequest pagarCuotaRequest);
  Future<InfoCreditosActivosResponse> infoCreditosActivos();
  Future<InfoCreditoySaldoResponse> infoCreditoySaldo(int idCredito);
  Future<PayFeeResponse> modificarFechaCuota(
    String fechaNueva,
    int idCredito,
  );
  Future<EstadoCreditoResponse> modificarEstadoCredito(
    int idCredito,
    int estadoCredito,
  );
  Future<AbonosRealizadosResponse> consultarAbonosRealizados(
    int idCredito,
  );
  Future<GenericoResponse> consultarAbonoPorId(
    int idCuotaCredito,
  );
}
