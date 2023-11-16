import 'package:intl/intl.dart';

class MonthFormat {
  static const List<String> monthNames = [
    "Enero",
    "Febrero",
    "Marzo",
    "Abril",
    "Mayo",
    "Junio",
    "Julio",
    "Agosto",
    "Septiembre",
    "Octubre",
    "Noviembre",
    "Diciembre",
  ];

  static const List<String> monthAbbreviatedNames = [
    "Ene",
    "Feb",
    "Mar",
    "Abr",
    "May",
    "Jun",
    "Jul",
    "Ago",
    "Sep",
    "Oct",
    "Nov",
    "Dic"
  ];

  static int nameToNumber({required String value}) => monthNames.indexOf(value);
  static String numberToName({required int value}) => monthNames[value];
  static String numberToAbbreviation({required int value}) =>
      monthAbbreviatedNames[value - 1];
}

class CurrencyFormat {
  static final _usCurrencyFormatter = NumberFormat("#,##0.00", "en_US");

  static String usCurrency({required num value}) =>
      "Q. ${_usCurrencyFormatter.format(value)}";
}
