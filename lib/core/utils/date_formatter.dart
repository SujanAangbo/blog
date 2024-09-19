import 'package:intl/intl.dart';

String formatDateByDDMMMYYYY(String date) {

  DateTime? localDate = DateTime.tryParse(date)?.toLocal();

  if(localDate == null) {
    return "";
  }

  final formatter = DateFormat("dd MMM, yyyy");
  return formatter.format(localDate);
}
