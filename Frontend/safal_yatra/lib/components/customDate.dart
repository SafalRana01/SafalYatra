import 'package:intl/intl.dart';

String formatDate(DateTime date) {
  return DateFormat('EEE, MMM d').format(
      date); // 'EEE' for abbreviated weekday, 'MMM' for abbreviated month, 'd' for day
}
