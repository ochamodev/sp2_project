import 'package:intl/intl.dart';

class MonthFormat {
  static const List<String> monthNames = [
    "January",
    "February",
    "March",
    "April",
    "May",
    "June",
    "July",
    "August",
    "September",
    "October",
    "November",
    "December"
  ];

  static const List<String> monthAbbreviatedNames = [
    "Jan",
    "Feb",
    "Mar",
    "Apr",
    "May",
    "Jun",
    "Jul",
    "Aug",
    "Sep",
    "Oct",
    "Nov",
    "Dec"
  ];

  static int nameToNumber({required String value}) => monthNames.indexOf(value);
  static String numberToName({required int value}) => monthNames[value];
  static String numberToAbbreviation({required int value}) =>
      monthAbbreviatedNames[value];
}

class CurrencyFormat {
  static final _usCurrencyFormatter = NumberFormat("#,##0.00", "en_US");

  static String usCurrency({required num value}) =>
      "\$${_usCurrencyFormatter.format(value)}";
}
