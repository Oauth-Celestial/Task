import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class DateHelper {
  static DateHelper shared = DateHelper();

  /// return string in format may 20, 2023
  String datetoString(DateTime date) {
    return DateFormat.yMMMMd().format(date);
  }

  /// converts your string to date which look like  may 20, 2023
  DateTime stringToDate(String date) {
    DateFormat format = DateFormat.yMMMMd('en_US');
    DateTime converted = format.parse(date);
    return converted;
  }

  /// converts your timestamp to date which look like  may 20, 2023
  String stringFromTimeStamp(Timestamp time) {
    var stamp =
        new DateTime.fromMillisecondsSinceEpoch(time.millisecondsSinceEpoch);
    return DateFormat.yMMMMd().format(stamp);
  }

  String getAMorPm(Timestamp time) {
    var stamp =
        new DateTime.fromMillisecondsSinceEpoch(time.millisecondsSinceEpoch);
    return DateFormat('hh a').format(stamp);
  }
}
