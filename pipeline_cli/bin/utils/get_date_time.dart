import 'package:intl/intl.dart';

String getDateTime() {
  var now = DateTime.now().toUtc();
  var formattedDate = DateFormat('yyyy-MM-dd').format(now);
  var formattedTime = DateFormat('HH:mm:ss').format(now);
  return 'Current Date: $formattedDate\nCurrent Time: $formattedTime UTC';
}
