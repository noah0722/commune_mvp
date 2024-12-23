import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;

class DateUtils {
  static String getTimeAgo(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    timeago.setLocaleMessages('ko', KoreanMessages());
    return timeago.format(now.subtract(difference), locale: 'ko');
  }

  static String formatDateTime(DateTime dateTime) {
    return DateFormat('yyyy-MM-dd HH:mm').format(dateTime);
  }

  static String formatDateOnly(DateTime dateTime) {
    return DateFormat('yyyy-MM-dd').format(dateTime);
  }

  static String formatMonthDay(DateTime dateTime) {
    return DateFormat('MM.dd').format(dateTime);
  }

  static bool isToday(DateTime dateTime) {
    final now = DateTime.now();
    return dateTime.year == now.year &&
        dateTime.month == now.month &&
        dateTime.day == now.day;
  }

  static bool isYesterday(DateTime dateTime) {
    final yesterday = DateTime.now().subtract(const Duration(days: 1));
    return dateTime.year == yesterday.year &&
        dateTime.month == yesterday.month &&
        dateTime.day == yesterday.day;
  }
}

class KoreanMessages implements timeago.LookupMessages {
  @override
  String prefixAgo() => '';

  @override
  String suffixAgo() => '전';

  @override
  String lessThanOneMinute(int seconds) => '방금';

  @override
  String aboutAMinute(int minutes) => '1분';

  @override
  String minutes(int minutes) => '$minutes분';

  @override
  String aboutAnHour(int minutes) => '1시간';

  @override
  String hours(int hours) => '$hours시간';

  @override
  String aDay(int hours) => '1일';

  @override
  String days(int days) => '$days일';

  @override
  String aboutAMonth(int days) => '1달';

  @override
  String months(int months) => '$months달';

  @override
  String aboutAYear(int year) => '1년';

  @override
  String years(int years) => '$years년';

  @override
  String wordSeparator() => ' ';

  // Add these required methods
  @override
  String prefixFromNow() => '';

  @override
  String suffixFromNow() => '후';
}
