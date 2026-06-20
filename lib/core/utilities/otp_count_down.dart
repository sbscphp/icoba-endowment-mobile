import 'dart:async';


class OTPCountDown {
  String _countDown = "";
  Timer _timer = Timer(const Duration(), () {});

  OTPCountDown.startOTPTimer({
    int timeInMS = 0,
    required void Function(String countDown) currentCountDown,
    required void Function() onFinish,
  }) {
    _timer = Timer.periodic(const Duration(milliseconds: 1000), (Timer timer) {
      timeInMS -= 1000;
      Duration duration = Duration(milliseconds: timeInMS);

      // Calculate minutes and seconds
      int minutes = duration.inMinutes;
      int seconds = duration.inSeconds % 60;

      // Format the countdown string as MM:SS
      String minutesInString = minutes.toString().padLeft(2, '0');
      String secondsInString = seconds.toString().padLeft(2, '0');
      _countDown = "$minutesInString:$secondsInString";

      // Pass the formatted countdown to the callback
      currentCountDown(_countDown);

      if (duration.inSeconds == 0) {
        onFinish();
        timer.cancel();
      }
    });
  }

  // OTPCountDown.startOTPTimer({
  //   int timeInMS = 0,
  //   required void Function(String countDown) currentCountDown,
  //   required void Function() onFinish,
  // }) {
  //   _timer = Timer.periodic(const Duration(milliseconds: 1000), (Timer timer) {
  //     timeInMS -= 1000;
  //     Duration duration = Duration(milliseconds: timeInMS);
  //
  //     if (duration.inSeconds % 60 == 0) {
  //       _countDown = "0";
  //     } else {
  //       int seconds = duration.inSeconds % 60;
  //       String secondsInString = seconds.toString();
  //       if (seconds < 10) {
  //         secondsInString = "$seconds";
  //       }
  //       _countDown = secondsInString;
  //     }
  //
  //     currentCountDown(_getCountDown);
  //
  //     if (duration.inSeconds == 0) {
  //       onFinish();
  //       timer.cancel();
  //     }
  //   });
  // }

  String get _getCountDown => _countDown;

  void cancelTimer() {
    if (_timer.isActive) {
      _timer.cancel();
    }
  }
}
