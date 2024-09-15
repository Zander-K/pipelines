import 'package:intl/intl.dart';

/// Returns a [Record] with the current date and time.
DateAndTime getDateTime() {
  final utc = DateTime.now().toUtc();
  final sast = utc.add(Duration(hours: 2));

  final formattedDate = DateFormat('yyyy-MM-dd').format(sast);
  final formattedTime = DateFormat('HH:mm:ss').format(sast);

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
