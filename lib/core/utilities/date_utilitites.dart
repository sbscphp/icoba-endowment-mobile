import 'package:intl/intl.dart';

class DateUtilities {
  static String dateFormatter(String date) {
    final formatter = DateFormat('yyyy-MM-dd');
    final dateTime = formatter.parse(date);
    final formatted = formatter.format(dateTime);
    //print('formated date: $formatted----');
    final reformatDate = formatted.split('-');
    final formattedDate =
        reformatDate[2] + '-' + reformatDate[1] + '-' + reformatDate[0];

    //print(formattedDate);
    return formattedDate;
  }

  static String yearMonthDay(String date) {
    final reformatDate = date.split('-');
    final formattedDate =
        reformatDate[2] + '-' + reformatDate[1] + '-' + reformatDate[0];
    //print('date sent to server: $formattedDate');
    return formattedDate;
  }

  //convert datetime format to Month, Day and Year
  static String dateToYmd(String date) {
    final formatter = DateFormat('yyyy-MM-dd');
    final dateTime = formatter.parse(date);
    final formattedDateTime = DateFormat.yMMMd().format(dateTime);

    return formattedDateTime;
  }

  static String dateToDmy({required DateTime date}) {
    String day = date.day.toString().padLeft(2, '0');
    String month = date.month.toString().padLeft(2, '0');
    String year = date.year.toString();
    return '$day/$month/$year';
  }

  //convert datetime format to Month, Day and Year
  static String dayDateAndTime(DateTime date) {
    /*var formatter = new DateFormat('yyyy-MM-dd');
    DateTime dateTime = formatter.parse(date);
    //var formattedDateTime = DateFormat.yMMMd().format(dateTime);*/

    final dateFormat = DateFormat.EEEE();
    return '''
${dateFormat.format(date)}, ${DateFormat.MMMd().format(date)}, ${DateFormat.j().format(date)}''';
  }

  ///convert datetime format to day and date
  static String dayAndDate(DateTime date) {
    return '''
${DateFormat.EEEE().format(date)}, ${DateFormat.yMMMMd().format(date)}''';
  }

  ///convert datetime format to abbrev week day, month and year
  static String abbrevDayMonthYear(DateTime date) {
    return '''
${DateFormat.E().format(date)}, ${getDayOfMonthSuffix(date)} ${DateFormat.MMM().format(date)}. ${DateFormat.y().format(date)}''';
  }

  ///returns first day and last day of current month
  static String currentMonth() {
    return '''
   ${getDayOfMonthSuffix(DateTime.now(), getFirstDay: true)} ${DateFormat.MMMM().format(DateTime.now())} ${DateFormat.y().format(DateTime.now())} to ${getDayOfMonthSuffix(DateTime.now(), getLastDay: true)} ${DateFormat.MMMM().format(DateTime.now())} ${DateFormat.y().format(DateTime.now())}''';
  }

  ///convert datetime format to day, month and year
  static String dMY(DateTime date) {
    try {
      return '''${getDayOfMonthSuffix(date)} ${DateFormat.MMMM().format(date)}, ${DateFormat.y().format(date)}''';
    } catch (e) {
      return '''${getDayOfMonthSuffix(DateTime.now())} ${DateFormat.MMMM().format(DateTime.now())}, ${DateFormat.y().format(DateTime.now())}''';
    }
  }

  ///convert datetime format to day, month and year
  static String dM(DateTime date) {
    try {
      return '''${getDayOfMonthSuffix(date)} ${DateFormat.MMMM().format(date)}''';
    } catch (e) {
      return '''${getDayOfMonthSuffix(DateTime.now())} ${DateFormat.MMMM().format(DateTime.now())}''';
    }
  }

  ///convert datetime format to day and month
  static String abbrevDMY(DateTime date) {
    return '''
${getDayOfMonthSuffix(date)} ${DateFormat.MMM().format(date)} ${DateFormat.y().format(date)}''';
  }

  ///convert datetime format to  month and year
  static String monthYear(DateTime date) {
    return '''
${DateFormat.MMMM().format(date)} ${DateFormat.y().format(date)}''';
  }

  ///convert datetime format to year
  static String year(DateTime date) {
    return '''
${DateFormat.y().format(date)}''';
  }

  static String abbrevDayMonthYearString(String date) {
    final formatter = DateFormat('yyyy-MM-dd');
    final dateTime = formatter.parse(date);
    return '''
${getDayOfMonthSuffix(dateTime)} ${DateFormat.MMM().format(dateTime)}. ${DateFormat.y().format(dateTime)}''';
  }

  static String abbrevDayDateMonthYearString(String? date) {
    if (date == null || date == 'null') return '';

    final formatter = DateFormat('yyyy-MM-dd');
    final dateTime = formatter.parse(date);
    return '''
${abbreviateDay(DateFormat.EEEE().format(dateTime))}, ${getDayOfMonthSuffix(dateTime)} ${DateFormat.MMM().format(dateTime)}. ${DateFormat.y().format(dateTime)}''';
  }

  ///(eg DEC 2Oth at 02.34pm)
  static String abbrevMonthDayTime(String date) {
    date = new DateFormat(
      "yyyy-MM-dd HH:mm:ss.SSSZ",
    ).parseUTC(date.toString()).toLocal().toString();
    final formatter = DateFormat('yyyy-MM-dd HH:mm:ss');
    final dateTime = formatter.parse(date);
    return '''
 ${DateFormat.MMM().format(dateTime).toUpperCase()} ${getDayOfMonthSuffix(dateTime)} at ${DateFormat.jm().format(dateTime)}''';
  }

  ///(eg 02:34pm)
  //  static String time(String date) {
  //    final formatter = DateFormat('yyyy-MM-dd HH:mm:ss');
  //    final dateTime = formatter.parse(date);
  //    return '''
  // ${DateFormat.MMM().format(dateTime).toUpperCase()} ${getDayOfMonthSuffix(dateTime)} at ${DateFormat.jm().format(dateTime)}''';
  //  }

  ///converts string date to DateTime and abbreviate
  static String abbrevDate(String date) {
    return '''
${getDayOfMonthSuffix(DateFormat('yyyy-MM-dd').parse(date))} ${DateFormat.MMM().format(DateFormat('yyyy-MM-dd').parse(date))} ${DateFormat.y().format(DateFormat('yyyy-MM-dd').parse(date))}''';
  }

  static String abbrevMonthDayYear(String date) {
    final String month = DateFormat.MMM().format(
      DateFormat('yyyy-MM-dd').parse(date),
    );
    return '''
  ${month.toUpperCase()} ${DateFormat.d().format(DateFormat('yyyy-MM-dd').parse(date))} ${DateFormat.y().format(DateFormat('yyyy-MM-dd').parse(date))}''';
  }

  static String abbreviateDayAndMonth(DateTime date) {
    return "${DateFormat.MMM().format(date)} ${DateFormat.d().format(date)}, ${DateFormat.y().format(date)}";
  }

  ///convert datetime to weekday
  static String abbreviateWeekDay(DateTime date) {
    return DateFormat.E().format(date);
  }

  ///convert date time to day
  static String day(DateTime date) {
    return DateFormat.d().format(date);
  }

  ///convert date time to month
  static String abbreviateMonth(DateTime date) {
    return DateFormat.MMM().format(date);
  }

  //convert datetime format to Month, Day and Year
  static String dateAndTime(DateTime date) {
    return '''
${DateFormat.yMMMd().format(date)} ${DateFormat.jms().format(date)}''';
  }

  ///convert datetime format to Month, Day, Year and time
  static String monthDayYearAndTime({DateTime? date}) {
    return "${DateFormat.yMMMd().format(date!)} ${DateFormat.jm().format(date)}";
  }

  static String dayMonthDatYearTime({DateTime? date}) {
    return DateFormat('EEEE, MMMM d, y. h:mm a').format(date!);
  }

  static String dayMonthDayYear({DateTime? date}) {
    return DateFormat('EEEE, MMMM d, y.').format(date!);
  }

  static String dayDateMonthYear({DateTime? date}) {
    return DateFormat('EEEE, d MMMM, y').format(date!);
  }

  ///converts to month, day and year
  static String monthDayYear({DateTime? date}) {
    if (date == null) return DateFormat.yMMMMd().format(DateTime.now());
    return DateFormat.yMMMMd().format(date);
  }

  ///converts to month, day and year
  static String dayMonthYear({DateTime? date}) {
    if (date == null) return DateFormat('dd MMMM y').format(DateTime.now());
    return DateFormat('dd MMMM y').format(date);
  }

  static String monthOnly({DateTime? date}) {
    date ??= DateTime.now();
    return DateFormat.MMMM().format(date);
  }

  ///convert datetime format to Month, Day, Year and time
  static String timeYearDateAndMonth({DateTime? date}) {
    return "${DateFormat.jm().format(date!)} ${DateFormat.yMMMd().format(date)}";
  }

  ///convert datetime format to Month, Day, Year and time
  static String timeYearDateAndMonthAbbrev({DateTime? date}) {
    return "${DateFormat.jm().format(date!)} ${DateFormat('dd/MM/yyyy').format(date)}";
  }

  ///converts dateTime to time
  static String time({DateTime? date}) {
    date = new DateFormat(
      "yyyy-MM-dd HH:mm:ss.SSSZ",
    ).parseUTC(date?.toString() ?? DateTime.now().toString()).toLocal();
    return "${DateFormat.jm().format(date)}";
  }

  ///converts time in am/pm
  static String formatTimeAMPM({required DateTime dateTime}) {
    final DateFormat formatter = DateFormat.jm();
    return formatter.format(dateTime).toLowerCase();
  }

  ///compares two date time
  static String actualDay(DateTime date) {
    date = new DateFormat(
      "yyyy-MM-dd HH:mm:ss.SSSZ",
    ).parseUTC(date.toString()).toLocal();
    String returnDate;
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = DateTime(now.year, now.month, now.day - 1);
    //final tomorrow = DateTime(now.year, now.month, now.day + 1);

    final dateToCheck = date;
    final aDate = DateTime(
      dateToCheck.year,
      dateToCheck.month,
      dateToCheck.day,
    );
    if (aDate == today) {
      returnDate = "Today";
    } else if (aDate == yesterday) {
      returnDate = "Yesterday";
    } else {
      returnDate =
          "${DateFormat.MMM().format(date)} ${DateFormat.d().format(date)}, ${DateFormat.y().format(date)}";
    }

    return returnDate;
  }

  ///checks if two date times are the same
  static bool isSameDate(DateTime date, DateTime other) {
    return date.year == other.year &&
        date.month == other.month &&
        date.day == other.day;
  }

  ///checks if two date times are the same year and month
  static bool isSameMonthAndYear(DateTime date, DateTime other) {
    return date.year == other.year && date.month == other.month;
  }

  ///checks if two date times are the same year, month and day
  static bool isSameMonthAndYearAndDay(DateTime date, DateTime other) {
    return date.year == other.year &&
        date.month == other.month &&
        date.day == other.day;
  }

  ///checks if two date times are the same year
  static bool isSameYear(DateTime date, DateTime other) {
    return date.year == other.year;
  }

  ///returns month suffix
  static String getDayOfMonthSuffix(
    DateTime date, {
    bool getFirstDay = false,
    bool getLastDay = false,
  }) {
    int dayNum;
    if (getFirstDay) {
      dayNum = 1;
    } else if (getLastDay) {
      dayNum = DateTime(date.year, date.month + 1, 0).day;
    } else {
      dayNum = int.parse(DateFormat.d().format(date).toString());
    }

    if (!(dayNum >= 1 && dayNum <= 31)) {
      throw Exception('Invalid day of month');
    }

    if (dayNum >= 11 && dayNum <= 13) {
      return '${dayNum}th';
    }

    switch (dayNum % 10) {
      case 1:
        return '${dayNum}st';
      case 2:
        return '${dayNum}nd';
      case 3:
        return '${dayNum}rd';
      default:
        return '${dayNum}th';
    }
  }

  static String getSuffix(int dayNum) {
    if (!(dayNum >= 1 && dayNum <= 31)) {
      throw Exception('Invalid day of month');
    }

    if (dayNum >= 11 && dayNum <= 13) {
      return '${dayNum}th';
    }

    switch (dayNum % 10) {
      case 1:
        return '${dayNum}st';
      case 2:
        return '${dayNum}nd';
      case 3:
        return '${dayNum}rd';
      default:
        return '${dayNum}th';
    }
  }

  ///days in a month(for savings)
  static List<String> savingDays = new List<String>.generate(
    31,
    (i) => getSuffix(int.parse((i + 1).toString())),
  );

  ///calculates the number of days between two date times
  static int daysBetween(String incomingDate) {
    final formatter = DateFormat('yyyy-MM-dd');
    final dateTime = formatter.parse(incomingDate);
    DateTime from = DateTime(
      DateTime.now().year,
      DateTime.now().month,
      DateTime.now().day,
    );
    DateTime to = DateTime(dateTime.year, dateTime.month, dateTime.day);
    //print("DAYS BETWEEN: ${(to.difference(from).inHours / 24).round()}>>>>");
    if ((to.difference(from).inHours / 24).round().toString().contains('-')) {
      int value = (to.difference(from).inHours / 24).round();
      String formattedString = value.toString().replaceAll(
        new RegExp(r"[^\s\w]"),
        '',
      );
      return int.parse(formattedString);
    }
    return (to.difference(from).inHours / 24).round();
  }

  ///checks if incoming date is before today
  static bool isBeforeNowOrToday({required DateTime? date}) {
    try {
      if (date == null) return false;
      DateTime now = DateTime.now();
      DateTime today = DateTime(now.year, now.month, now.day);
      DateTime target = DateTime(date.year, date.month, date.day);
      return target.isBefore(today) || target.isAtSameMomentAs(today);
    } catch (e) {
      return false;
    }
  }

  static List<String> monthsOfTheYear = [
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
    'December',
  ];

  static List<String> abrevMonthsOfTheYear = [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec',
  ];

  ///time
  static List<String> hours = [
    "12:00 AM",
    "1:00 AM",
    "2:00 AM",
    "3:00 AM",
    "4:00 AM",
    "5:00 AM",
    "6:00 AM",
    "7:00 AM",
    "8:00 AM",
    "9:00 AM",
    "10:00 AM",
    "11:00 AM",
    "12:00 PM",
    "1:00 PM",
    "2:00 PM",
    "3:00 PM",
    "4:00 PM",
    "5:00 PM",
    "6:00 PM",
    "7:00 PM",
    "8:00 PM",
    "9:00 PM",
    "10:00 PM",
    "11:00 PM",
  ];

  ///hours of the day
  static List<String> hoursOfDay = [
    '01',
    '02',
    '03',
    '04',
    '05',
    '06',
    '07',
    '08',
    '09',
    '10',
    '11',
    '12',
  ];

  ///year range for custom month and year selector
  static List<String> years = new List<String>.generate(
    200,
    (i) => (1900 + i).toString(),
  );

  ///converts to dateTime
  static DateTime formatTime({required String timeStamp}) {
    DateTime formattedTime;
    try {
      formattedTime = DateFormat(
        "E MMM dd yyyy HH:mm:ss 'GMT'Z",
        "en_US",
      ).parse(timeStamp);
    } catch (e) {
      formattedTime = DateTime.now();
    }

    return formattedTime;
  }

  ///converts time(am/pm) in string format to dateTime(GMT)
  static String formatTimeOfDay({required String timeStamp}) {
    String formattedTime;
    DateTime time = DateFormat('hha').parse(timeStamp.toUpperCase());
    DateFormat formatter = DateFormat('HH:mm');
    formattedTime = formatter.format(time);
    return formattedTime;
  }

  ///converts GMT to am/pm
  static String formatFromGMT({required String timeStamp}) {
    if (timeStamp.isEmpty || timeStamp.contains("undefined")) {
      String formattedTime = DateFormat('hha').format(DateTime.now());
      return formattedTime;
    }
    String formattedTime;
    DateFormat formatter = DateFormat('hha');
    DateTime time = DateFormat('HH:mm').parse(timeStamp);
    formattedTime = formatter.format(time);
    return formattedTime;
  }

  ///abbreviate string
  static String abbreviateDay(String? day) {
    if (day == null) return '';

    if (day.toLowerCase() == 'thursday') return day.substring(0, 4);

    return day.substring(0, 3);
  }

  ///greet user based on hour of day
  static String greeting() {
    DateTime now = DateTime.now();
    int hour = now.hour;

    String greeting;
    if (hour < 12) {
      greeting = "Good morning!";
    } else if (hour < 18) {
      greeting = "Good afternoon!";
    } else {
      greeting = "Good evening!";
    }

    return greeting;
  }

  /// returns time of day as a plain label
  static String timeOfDay() {
    int hour = DateTime.now().hour;

    if (hour >= 5 && hour < 12) {
      return "morning";
    } else if (hour >= 12 && hour < 17) {
      return "afternoon";
    } else if (hour >= 17 && hour < 21) {
      return "evening";
    } else {
      return "night";
    }
  }

  ///days in a week
  static List<String> daysInAWeek = [
    "Sunday",
    "Monday",
    "Tuesday",
    "Wednesday",
    "Thursday",
    "Friday",
    "Saturday",
  ];

  ///days remaining before loan application
  static String daysLeft(int day) {
    String currentDay = DateFormat('EEEE').format(DateTime.now());
    int cDay = daysInAWeek.indexOf(currentDay) + 1;
    int daysRemaining = day - cDay;
    if (daysRemaining < 0) {
      daysRemaining = (7 - cDay) + day;
    }

    //int formattedDay = int.parse(daysRemaining.toString().replaceAll("-", ""));
    if (daysRemaining > 1) return "$daysRemaining days";

    return "$daysRemaining day";
  }

  ///get time difference
  static String getTimeDifference({required DateTime targetDate}) {
    DateTime now = DateTime.now();

    // if (now.isAfter(targetDate)) {
    //   return "You can re-check now";
    // }

    Duration difference = targetDate.difference(now);

    if (difference.inDays >= 1) {
      return "${difference.inDays} day(s)";
    } else if (difference.inHours >= 1) {
      return "${difference.inHours} hour(s)";
    } else if (difference.inMinutes >= 1) {
      return "${difference.inMinutes} minute(s)";
    } else {
      return "${difference.inSeconds} second(s)";
    }
  }

  ///returns gmt
  static String gmt({required DateTime dateTime}) {
    DateTime dateTimeUtc = dateTime.toUtc();
    return DateFormat('HH:mm').format(dateTimeUtc);
  }

  // formats date to format -> Friday October 4, 2024
  static String formatDateToEMdy(DateTime dateTime) {
    try {
      // Create a DateFormat object for the desired output format
      DateFormat outputFormat = DateFormat('EEEE MMMM d, yyyy');

      // Format the DateTime object to the desired string format
      String formattedDate = outputFormat.format(dateTime);

      return formattedDate;
    } catch (e) {
      // Handle any parsing errors
      print('Error parsing date: $e');
      return 'Invalid Date';
    }
  }

  //reverse date string
  static String reverseDate(String date) {
    if (date.isEmpty) return '';

    //Split the string by '-'
    List<String> dateParts = date.split('-');

    //Rearrange and return the reversed date
    return '${dateParts[2]}-${dateParts[1]}-${dateParts[0]}';
  }

  //converts days to years(365 days => 1 year)
  static String convertToYear({required int totalDays}) {
    const int daysInYear = 365;
    const int daysInMonth = 30;

    //Calculate years, months, and remaining days
    int years = totalDays ~/ daysInYear;
    int remainingDaysAfterYears = totalDays % daysInYear;
    int months = remainingDaysAfterYears ~/ daysInMonth;
    //int remainingDays = remainingDaysAfterYears % daysInMonth;

    if (years > 0) {
      if (months > 0) {
        return '$years year${years > 1 ? 's' : ''} and $months month${months > 1 ? 's' : ''}';
      } else {
        return '$years year${years > 1 ? 's' : ''}';
      }
    } else if (totalDays >= daysInMonth) {
      return '$totalDays days';
    } else {
      return '$totalDays day${totalDays > 1 ? 's' : ''}';
    }
  }

  static String getTimeAgo(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inSeconds < 60) {
      return 'Just now';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes} ${difference.inMinutes == 1 ? 'min' : 'mins'} ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours} ${difference.inHours == 1 ? 'hour' : 'hours'} ago';
    } else if (difference.inDays < 30) {
      return '${difference.inDays} ${difference.inDays == 1 ? 'day' : 'days'} ago';
    } else if (difference.inDays < 365) {
      final months = (difference.inDays / 30).floor();
      return '$months ${months == 1 ? 'month' : 'months'} ago';
    } else {
      final years = (difference.inDays / 365).floor();
      return '$years ${years == 1 ? 'year' : 'years'} ago';
    }
  }

  static String timeAgo({required DateTime dateTime}) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inSeconds < 60) {
      return 'now';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes} min${difference.inMinutes > 1 ? 's' : ''} ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours} hr${difference.inHours > 1 ? 's' : ''} ago';
    } else if (difference.inDays <= 5) {
      return '${difference.inDays} day${difference.inDays > 1 ? 's' : ''} ago';
    } else {
      return '${dateTime.day.toString().padLeft(2, '0')}/${dateTime.month.toString().padLeft(2, '0')}/${dateTime.year}';
    }
  }

  static String dayDateYear({required DateTime date}) {
    //Weekday abbreviation (e.g., "Tues.")
    final String weekday = DateFormat('EEE').format(date);

    //Month name (e.g., "May")
    final String month = DateFormat('MMMM').format(date);

    //Day with ordinal suffix (e.g., "20th")
    final int day = date.day;
    final String suffix = getSuffix(day);

    return '$weekday. $suffix $month, ${date.year}';
  }
}
