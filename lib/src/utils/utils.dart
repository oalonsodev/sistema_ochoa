import 'package:intl/intl.dart';

bool isToday(String date) {
  var currentDate = DateFormat('dd/MM/yyyy').format(DateTime.now());

  if (date == currentDate)
    return true;
  else
    return false;
}

String formFieldIsEmpty(String value) {
  return (value.isEmpty) ? "Rellene este campo" : null;
}
