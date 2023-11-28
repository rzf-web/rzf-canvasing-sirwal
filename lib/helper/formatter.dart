import 'package:intl/intl.dart';

String doubleFormatter(double data) {
  RegExp regex = RegExp(r'([.]*0)(?!.*\d)');
  String s = data.toString().replaceAll(regex, '');
  return s;
}

String percentFormatter(double data) {
  String formattedNumber = data.toStringAsFixed(2);
  formattedNumber = formattedNumber.replaceAll(RegExp(r"0*$"), "");
  var lastChar = formattedNumber[formattedNumber.length - 1];
  if (lastChar == '.') {
    formattedNumber = formattedNumber.substring(0, formattedNumber.length - 1);
  }
  return formattedNumber;
}

String dateFormatUI(DateTime date, {String? format}) {
  return DateFormat(format ?? "dd MMMM yyyy", 'id').format(date);
}

String dateFormatAPI(DateTime date) {
  return DateFormat("dd-MM-yyyy", 'id').format(date);
}

String moneyFormatter(double money) {
  return NumberFormat.currency(
    locale: 'id',
    symbol: "Rp ",
    decimalDigits: 0,
  ).format(money);
}

String numberFormatter(double money) {
  return NumberFormat.currency(
    locale: 'id',
    symbol: "",
    decimalDigits: 0,
  ).format(money);
}
