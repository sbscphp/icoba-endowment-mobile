class RemainingTime {
  final int days;
  final int hours;
  final int minutes;
  final int seconds;

  const RemainingTime({
    required this.days,
    required this.hours,
    required this.minutes,
    required this.seconds,
  });

  //Factory for convenience
  factory RemainingTime.fromDuration(Duration d) {
    return RemainingTime(
      days: d.inDays,
      hours: d.inHours.remainder(24),
      minutes: d.inMinutes.remainder(60),
      seconds: d.inSeconds.remainder(60),
    );
  }

  static const zero = RemainingTime(days: 0, hours: 0, minutes: 0, seconds: 0);
}