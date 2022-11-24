import 'package:intl/intl.dart';

String getFormattedDate(num time, {String pattern = 'yyyy-MM-dd'}) {
  final dt = DateTime.fromMillisecondsSinceEpoch(time.toInt() * 1000);
  return DateFormat(pattern).format(dt);
}

String getFormattedCurrentTime({required String pattern}){
  return DateFormat(pattern).format(DateTime.now());
}
