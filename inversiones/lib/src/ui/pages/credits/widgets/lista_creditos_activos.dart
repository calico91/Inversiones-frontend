import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inversiones/src/ui/pages/credits/credits_controller.dart';
import 'package:inversiones/src/ui/pages/utils/general.dart';
import 'package:inversiones/src/ui/pages/widgets/inputs/text_field_search.dart';
import 'package:inversiones/src/ui/pages/widgets/loading/loading.dart';

class ListaCreditosActivos extends StatelessWidget {
  const ListaCreditosActivos({super.key});
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
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
              height: size.height * 0.48,
              width: size.width * 0.82,
              child: Column(
                children: [
                  TextFieldSearch(
                    labelText: 'Buscar credito',
                    onChanged: (value) => controller.buscarCredito(value),
                  ),
                  _listaClientes(controller, size),
                ],
              ),
            ),
          ),
        ],
      );
    });
  }

  Widget _listaClientes(CreditsController controller, Size size) {
    return Expanded(
      child: ListView.builder(
        itemCount: controller.filtroCreditos.value.length,
        itemBuilder: (_, index) {
          return Card(
            child: ListTile(
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
          Text(
            overflow: TextOverflow.ellipsis,
            "${controller.filtroCreditos.value[index].nombres} ${controller.filtroCreditos.value[index].apellidos}",
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
}
