import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inversiones/src/ui/pages/credits/credits_controller.dart';
import 'package:inversiones/src/ui/pages/utils/enums.dart';
import 'package:inversiones/src/ui/pages/utils/general.dart';
import 'package:inversiones/src/ui/pages/widgets/inputs/text_field_base.dart';
import 'package:inversiones/src/ui/pages/widgets/inputs/text_field_search.dart';
import 'package:inversiones/src/ui/pages/widgets/loading/loading.dart';

class ListaCreditosActivos extends StatelessWidget {
  const ListaCreditosActivos({super.key});
  @override
  Widget build(BuildContext context) {
    final CreditsController controller = Get.find<CreditsController>();
    return Obx(() {
      if (controller.status.value != 200) {
        return const Loading(
          vertical: 110,
        ).circularLoading();
      }
      return Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SizedBox(
              height: General.mediaQuery(context).height * 0.48,
              width: General.mediaQuery(context).width * 0.82,
              child: Column(
                children: [
                  TextFieldSearch(
                    labelText: 'Buscar credito',
                    onChanged: (value) => controller.buscarCredito(value),
                  ),
                  _listaClientes(
                      controller, General.mediaQuery(context), context),
                ],
              ),
            ),
          ),
        ],
      );
    });
  }

  Widget _listaClientes(
    CreditsController controller,
    Size size,
    BuildContext context,
  ) {
    return Expanded(
      child: ListView.builder(
        itemCount: controller.filtroCreditos.value.length,
        itemBuilder: (_, index) {
          return Card(
            child: ListTile(
              onTap: () => controller.infoCreditoySaldo(
                controller.filtroCreditos.value[index].idCredito!,
              ),
              title: _showClientTitle(controller, index, size),
              subtitle: _informacionSubtitulo(controller, index),
            ),
          );
        },
      ),
    );
  }

  Widget _showClientTitle(CreditsController controller, int index, Size size) {
    return SizedBox(
      width: size.width * 0.47,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: size.width * 0.5,
            child: Text(
              overflow: TextOverflow.ellipsis,
              "${controller.filtroCreditos.value[index].idCredito}.${controller.filtroCreditos.value[index].nombres} ${controller.filtroCreditos.value[index].apellidos}",
            ),
          ),
          Text(
            "${General.formatoMoneda(controller.filtroCreditos.value[index].valorCredito)} ",
          ),
        ],
      ),
    );
  }

  Widget _informacionSubtitulo(CreditsController controller, int index) {
    return Text(
      'Fecha credito: ${controller.filtroCreditos.value[index].fechaCredito}',
    );
  }

  Future _modalInfoCreditoSaldo(
    Size size,
    String mensaje,
    BuildContext context,
    CreditsController controller,
  ) {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('titulo'),
        content: SizedBox(
          height: size.height * 0.17,
          child: Column(
            children: [
              Text(
                textAlign: TextAlign.center,
                mensaje,
              ),
              const SizedBox(
                height: 20,
              ),
              Form(
                key: controller.formKeyAbonarCapital,
                child: TextFieldBase(
                  title: 'Valor Abonar',
                  controller: controller.abonarCapital,
                  textInputType: TextInputType.number,
                  validateText: ValidateText.creditValue,
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {},
            child: const Text('Abonar capital'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cerrar'),
          ),
        ],
      ),
    );
  }
}
