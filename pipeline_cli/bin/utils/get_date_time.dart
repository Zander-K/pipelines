import 'package:intl/intl.dart';

(String, String) getDateTime() {
  var now = DateTime.now().toUtc();
  var formattedDate = DateFormat('yyyy-MM-dd').format(now);
  var formattedTime = DateFormat('HH:mm:ss').format(now);
  return (formattedDate, formattedTime);
}
