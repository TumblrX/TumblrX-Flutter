///This functions takes the [timestamp] in this format 2021-12-25T15:47:33.371Z and returns it in this form:
///if the timestamp is today: Today, hh:mm
///if the timestamp is yesterday: Yesterday, hh:mm
///if the timestamp is This week: Sunday, hh:mm
///if the timestamp is This year: November 21, hh:mm
///otherwise: 1999 November 21, hh:mm
///The input time is in GMT, output is GMT+2
String changeTimeFormat(String timestamp) {
  DateTime stamp;
  try {
    stamp = DateTime.parse(timestamp.substring(0, timestamp.length - 1));
  } catch (e) {
    return '';
  }
  stamp = stamp.add(Duration(hours: 2)); //GMT+2
  DateTime now = DateTime.now();
  List<String> months = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December'
  ];
  List<String> days = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday',
  ];

  if (now.day == stamp.day) {
    return 'Today, ${stamp.hour}:${addZeroToSingleDigit(stamp.minute.toString())}';
  }
  if (now.day - stamp.day == 1) {
    return 'Yesterday, ${stamp.hour}:${addZeroToSingleDigit(stamp.minute.toString())}';
  }
  if (now.difference(stamp).inDays < 7) {
    return '${days[stamp.weekday - 1]}, ${stamp.hour}:${addZeroToSingleDigit(stamp.minute.toString())}';
  }
  if (now.difference(stamp).inDays < 365) {
    return '${months[stamp.month - 1]} ${stamp.day}, ${stamp.hour}:${addZeroToSingleDigit(stamp.minute.toString())}';
  }
  return '${stamp.year} ${months[stamp.month - 1]} ${stamp.day}, ${stamp.hour}:${addZeroToSingleDigit(stamp.minute.toString())}';
}

///compares [timestamp1] and [timestamp2] and returns true if the difference is bigger than 30 minutes
bool isDifferenceBiggerThanHalfAnHour(String timestamp1, String timestamp2) {
  try {
    DateTime stamp1 =
        DateTime.parse(timestamp1.substring(0, timestamp1.length - 1));
    DateTime stamp2 =
        DateTime.parse(timestamp2.substring(0, timestamp2.length - 1));
    return stamp2.difference(stamp1).inMinutes > 30;
  } catch (e) {
    return false;
  }
}

///Adds zero to single digit minute
String addZeroToSingleDigit(String number) {
  if (number.length == 1) {
    number = '0' + number;
  }
  return number;
}
