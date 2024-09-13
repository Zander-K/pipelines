import 'package:intl/intl.dart';

/// Returns a [Record] with the current date and time
DateAndTime getDateTime() {
  var now = DateTime.now().toLocal();
  var formattedDate = DateFormat('yyyy-MM-dd').format(now);
  var formattedTime = DateFormat('HH:mm:ss').format(now);

  return DateAndTime(date: formattedDate, time: formattedTime);
}

class DateAndTime {
  DateAndTime({
    required this.date,
    required this.time,
  });

  final String date;
  final String time;
}
