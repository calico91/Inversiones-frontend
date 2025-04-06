import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inversiones/src/ui/pages/home/home_controller.dart';
import 'package:inversiones/src/ui/pages/pay_fee/pay_fee_controller.dart';
import 'package:inversiones/src/ui/pages/utils/general.dart';
import 'package:inversiones/src/ui/pages/widgets/card/custom_card_list.dart';
import 'package:inversiones/src/ui/pages/widgets/inputs/text_field_search.dart';
import 'package:inversiones/src/ui/pages/widgets/loading/loading.dart';

class ClientsPendingInstallmentsMolecule extends StatelessWidget {
  const ClientsPendingInstallmentsMolecule({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeController controller = Get.find<HomeController>();

    return Obx(
      () {
        if (controller.loading) {
          return const Expanded(
              child: Loading(horizontal: 0.11, vertical: 0.17));
        } else if (!controller.loading && controller.clients.isEmpty) {
          return Expanded(
            child: Column(
              children: [
                Image.asset(
                  'assets/sin_creditos_pendientes.png',
                  width: double.infinity,
                  height: General.mediaQuery(context).height * 0.35,
                ),
                const Text(
                  'No hay créditos pendientes.',
                  style: TextStyle(fontSize: 18),
                ),
              ],
            ),
          );
        }
        return Obx(
          () => Expanded(
            child: Column(
              children: [
                const SizedBox(height: 15),
                TextFieldSearch(
                  widthTextFieldSearch: 0.7,
                  controller: controller.buscarClienteCtrl,
                  labelText: 'Buscar cliente',
                  onChanged: (value) => controller.buscarCliente(value, true),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: controller.filtroClientes.value.length,
                    itemBuilder: (_, index) {
                      return CustomCardList(
                        child: ListTile(
                          onTap: () async {
                            controller.idCliente(controller
                                .filtroClientes.value[index].idCliente);
                            controller.idCredito(controller
                                .filtroClientes.value[index].idCredito);
                            controller.nombreCliente(
                                '${controller.filtroClientes.value[index].nombres} ${controller.filtroClientes.value[index].apellidos}');
                            await Get.put(PayFeeController()).loadPayFee();
                          },
                          title: _showClientTitle(
                              controller, index, General.mediaQuery(context)),
                          subtitle: _showClientSubtitle(
                              controller, index, General.mediaQuery(context)),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  ///titulo que se muestra informacion clientes
  Widget _showClientTitle(HomeController controller, int index, Size size) =>
      Row(children: [
        SizedBox(
            width: size.width * 0.7,
            child: Text(
              overflow: TextOverflow.ellipsis,
              "${controller.filtroClientes.value[index].idCredito}.${controller.filtroClientes.value[index].nombres} ${controller.filtroClientes.value[index].apellidos}",
            )),
        Expanded(child: Container()),
      ]);

  Widget _showClientSubtitle(HomeController controller, int index, Size size) {
    final String valorCuota = General.formatoMoneda(
        controller.filtroClientes.value[index].valorCuota);
    return Row(
      children: [
        SizedBox(
          width: size.width * 0.33,
          child: Text(
            overflow: TextOverflow.ellipsis,
            "Fecha:${controller.filtroClientes.value[index].fechaCuota}",
          ),
        ),
        Expanded(child: Container()),
        SizedBox(
          width: size.width * 0.40,
          child: Text(
            textAlign: TextAlign.right,
            overflow: TextOverflow.ellipsis,
            "Cuota normal: $valorCuota",
          ),
        ),
      ],
    );
  }
}
