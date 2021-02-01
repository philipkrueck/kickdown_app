import 'package:flutter/material.dart';

import '../styles.dart';

class CountdownLabel extends StatelessWidget {
  final DateTime endDate;
  final bool isSold;
  final bool currentUserIsHighestBidder;

  const CountdownLabel(
      {this.endDate,
      this.isSold = false,
      this.currentUserIsHighestBidder = false});

  Duration get durationUntilEnd {
    return endDate.difference(DateTime.now());
  }

  String get timeDifferenceString {
    if (isSold) {
      return 'Verkauft';
    }

    if (currentUserIsHighestBidder) {
      return 'Sie sind Höchstbietender';
    }

    if (durationUntilEnd.inHours <= 12) {
      return durationInHoursMinSecs(durationUntilEnd);
    } else if (durationUntilEnd.inDays == 1) {
      return "Noch 1 Tag";
    } else if (durationUntilEnd.inDays >= 2) {
      return "Noch ${durationUntilEnd.inDays} Tage";
    } else {
      return durationUntilEnd.toString();
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
    return Card(
      color: currentUserIsHighestBidder
          ? Styles.annotationBadgeColor
          : Styles.accentColor01,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(8, 3, 7, 2),
        child: Row(
          children: [
            durationUntilEnd.inHours <= 12
                ? Icon(Icons.timer_sharp, color: Colors.white)
                : Container(),
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
