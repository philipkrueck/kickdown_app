import 'dart:async';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:kickdown_app/styles.dart';

class CountdownLabel extends StatefulWidget {
  final DateTime endDate;
  final bool isSold;

  const CountdownLabel({
    this.endDate,
    this.isSold = false,
  });

  @override
  _CountdownLabelState createState() => _CountdownLabelState();
}

class _CountdownLabelState extends State<CountdownLabel> {
  Timer timer;

  @override
  void initState() {
    super.initState();

    if (!widget.isSold) {
      timer = Timer.periodic(Duration(seconds: 1), (Timer t) {
        setState(() {});
      });
    }
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  Duration get durationUntilEnd {
    Duration duration = widget.endDate.difference(DateTime.now());
    return duration >= duration ? duration : 0.0;
  }

  String get timeDifferenceString {
    if (widget.isSold || durationUntilEnd.inSeconds <= 0) {
      return 'Verkauft';
    }

    if (durationUntilEnd.inHours <= 23) {
      return durationInHoursMinSecs(durationUntilEnd);
    } else if (durationUntilEnd.inHours <= 47) {
      return "Noch 1 Tag";
    } else {
      return "Noch ${durationUntilEnd.inDays} Tage";
    }
  }

  String durationInHoursMinSecs(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          color: Styles.accentColor01Normal),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(8, 3, 7, 2),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            durationUntilEnd.inHours <= 12
                ? Image.asset(
                    'assets/ic_timer.png',
                    width: 15,
                    height: 15,
                  )
                : Container(),
            SizedBox(width: 4),
            Text(
              timeDifferenceString,
              style: Styles.title04,
            ),
          ],
        ),
      ),
    );
  }
}
