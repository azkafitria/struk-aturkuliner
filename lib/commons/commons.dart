import 'package:intl/intl.dart';

const String beUrl = 'https://aturkuliner.id';

String formatPrice(String string) {
  final price = int.parse(stringMatchRegEx00(string));
  if (price == 0) return 'Rp 0';
  NumberFormat currencyFormatter = NumberFormat.currency(
    locale: 'id',
    symbol: 'Rp ',
    decimalDigits: 0,
  );
  return currencyFormatter.format(price);
}

String stringMatchRegEx00(String string) {
  if (string.contains(".")) {
    RegExp regExp = RegExp(r"^(.*?)(?=\.)");
    return regExp.stringMatch(string).toString();
  }
  return string;
}

String formatDate(String stringDate) {
  DateTime dateTime = DateTime.parse(stringDate);
  var date = DateFormat('d').format(dateTime).toString();
  var month = formatMonth(stringDate);
  var year = DateFormat('yyyy').format(dateTime).toString();
  var hour = DateFormat('HH').format(dateTime).toString();
  var minute = DateFormat('mm').format(dateTime).toString();
  return "$date $month $year, $hour:$minute";
}

String formatDay(String stringDate) {
  DateTime dateTime = DateFormat("dd-MM-yyyy").parse(stringDate);
  var day = DateFormat('EEEE').format(dateTime);
  switch (day) {
    case 'Sunday': return "Minggu";
    case 'Monday': return "Senin";
    case 'Tuesday': return "Selasa";
    case 'Wednesday': return "Rabu";
    case 'Thursday': return "Kamis";
    case 'Friday': return "Jumat";
    case 'Saturday': return "Sabtu";
  }
  return "";
}

String formatMonth(String stringDate) {
  DateTime dateTime = DateTime.parse(stringDate);
  var month = DateFormat('MM').format(dateTime);
  switch (month) {
    case '01': return "Jan";
    case '02': return "Feb";
    case '03': return "Mar";
    case '04': return "Apr";
    case '05': return "Mei";
    case '06': return "Jun";
    case '07': return "Jul";
    case '08': return "Agu";
    case '09': return "Sep";
    case '10': return "Okt";
    case '11': return "Nov";
    case '12': return "Des";
  }
  return "";
}