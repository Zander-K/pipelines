import 'package:intl/intl.dart';

/// Returns a [Record] with the current date and time
({String date, String time}) getDateTime() {
  var now = DateTime.now().toUtc();
  var formattedDate = DateFormat('yyyy-MM-dd').format(now);
  var formattedTime = DateFormat('HH:mm:ss').format(now);

  return (date: formattedDate, time: formattedTime);
}
