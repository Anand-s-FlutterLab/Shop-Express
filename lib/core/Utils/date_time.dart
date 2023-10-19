import 'package:intl/intl.dart';

String dateFormatter({required String dateFormat, int deliveryDelay = 0}) {
  DateTime date = DateTime.now();
  DateTime expectedDeliveryDate = DateTime(
    date.year,
    date.month,
    date.day + deliveryDelay,
    date.hour,
    date.minute,
    date.second,
  ).toLocal();
  DateTime formattedDate =
      DateFormat("yyyy-MM-dd hh:mm:ss").parse(expectedDeliveryDate.toString());
  return DateFormat(dateFormat).format(formattedDate);
}

String numberFormatter(double amount){
  var f = NumberFormat("#,##,##,###.##", "en_US");
  return f.format(amount);
}
