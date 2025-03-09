import 'package:intl/intl.dart';

String convertDateToNormal(String? date) {
  if (date == null || date.isEmpty) return "";

  try {
    // Normalize timestamp format (handle fractional seconds)
    String normalizedTimestamp = date.replaceFirst(RegExp(r'\.\d+Z'), 'Z');

    // Attempt to parse the date
    DateTime dateTime = DateTime.parse(normalizedTimestamp).toUtc();

    // Format the date
    DateFormat formatter = DateFormat("hh:mma MMM d yyyy");
    return formatter.format(dateTime);
  } catch (e) {
    return "Invalid Date";
  }
}
