import 'package:intl/intl.dart';

class General {
  const General();

  static String formatoMoneda(dynamic value) {
    final NumberFormat response = NumberFormat("\$#,##0", "es_CO");
    return response.format(value);
  }

  static String formatoFecha(DateTime date) =>
      DateFormat('yyyy-MM-dd').format(date);

  ///quita las comas del string que viene del input
  static double stringToDouble(String value) =>
      double.parse(value.replaceAll(',', '').trim());
}
