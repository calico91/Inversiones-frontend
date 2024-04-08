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
    final CreditsController controller = Get.find<CreditsController>();
    return Obx(() {
      if (controller.status.value != 200) {
        return Loading(
          vertical: General.mediaQuery(context).height * 0.1,
        );
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
                    controller: controller.campoBuscarCliente,
                    labelText:
                        'Buscar credito ${controller.creditosActivos.value.length}',
                    onChanged: (value) => controller.buscarCredito(value),
                  ),
                  _listaClientes(
                    controller,
                    General.mediaQuery(context),
                    context,
                  ),
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
              title: _showClientTitle(controller, index, size),
              subtitle: _informacionSubtitulo(controller, index, context),
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

  Widget _informacionSubtitulo(
    CreditsController controller,
    int index,
    BuildContext context,
  ) {
    return Row(
      children: [
        Text(
          'Fecha credito: ${controller.filtroCreditos.value[index].fechaCredito}',
        ),
        const Expanded(child: SizedBox()),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            IconButton(
              tooltip: 'Informacion credito',
              onPressed: () {
                controller.infoCreditoySaldo(
                  controller.filtroCreditos.value[index].idCredito!,
                  General.mediaQuery(context),
                );
                FocusScope.of(context).requestFocus(FocusNode());
              },
              icon: const Icon(Icons.info),
              color: Colors.blue,
              iconSize: 32,
            ),
            IconButton(
              tooltip: 'Informacion abonos',
              onPressed: () {
                controller.consultarAbonosRealizados(
                  controller.filtroCreditos.value[index].idCredito!,
                  General.mediaQuery(context),
                );
                FocusScope.of(context).requestFocus(FocusNode());
              },
              icon: const Icon(
                Icons.document_scanner_outlined,
                color: Colors.blue,
              ),
              iconSize: 32,
            ),
          ],
        ),
      ],
    );
  }
}
