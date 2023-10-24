import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:inversiones/src/ui/pages/credits/credits_controller.dart';
import 'package:inversiones/src/ui/pages/utils/enums.dart';
import 'package:inversiones/src/ui/pages/widgets/inputs/text_field_base.dart';
import 'package:inversiones/src/ui/pages/widgets/inputs/text_field_calendar.dart';

class Credits extends StatelessWidget {
  const Credits({super.key});
  @override
  Widget build(BuildContext context) {
    final CreditsController controller = Get.find<CreditsController>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Creditos'),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 10),
            child: Form(
              key: controller.formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      TextFieldBase(
                        paddingHorizontal: 20,
                        title: 'Valor credito',
                        controller: controller.creditValue,
                        textInputType: TextInputType.number,
                        validateText: ValidateText.onlyNumbers,
                      ),
                      TextFieldBase(
                        title: 'Interes',
                        controller: controller.interestPercentage,
                        textInputType: TextInputType.number,
                        validateText: ValidateText.onlyNumbers,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      TextFieldBase(
                        paddingHorizontal: 20,
                        title: 'Cantidad cuotas',
                        controller: controller.installmentAmount,
                        textInputType: TextInputType.number,
                        validateText: ValidateText.onlyNumbers,
                      ),
                      TextFieldBase(
                        textAlign: TextAlign.left,
                        title: 'Documento cliente',
                        controller: controller.document,
                        textInputType: TextInputType.number,
                        validateText: ValidateText.onlyNumbers,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      TextFieldCalendar(
                        paddingHorizontal: 20,
                        controller: controller.creditDate,
                        onTap: () async =>
                            showCalendar(context, controller.creditDate),
                        title: 'Fecha credito',
                      ),
                      TextFieldCalendar(
                        controller: controller.installmentDate,
                        onTap: () async =>
                            showCalendar(context, controller.installmentDate),
                        title: 'Couta credito',
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> showCalendar(
    BuildContext context,
    TextEditingController controllerField,
  ) async {
    final DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2023),
        lastDate: DateTime(2050));

    if (pickedDate != null) {
      final String formattedDate = DateFormat('dd-MM-yyyy').format(pickedDate);
      controllerField.text = formattedDate;
    } else {
      print("Date is not selected");
    }
  }
}


  /*    DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2023),
                            lastDate: DateTime(2050));

                        if (pickedDate != null) {
                          print(pickedDate);
                          String formattedDate =
                              DateFormat('dd-MM-yyyy').format(pickedDate);
                          print(formattedDate);
                          controller.creditDate.text = formattedDate;
                        } else {
                          print("Date is not selected");
                        }
} */
