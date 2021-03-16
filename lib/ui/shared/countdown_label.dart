import 'dart:async';
import 'dart:math';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:kickdown_app/styles.dart';

class CountdownLabel extends StatefulWidget {
  final DateTime endDate;
  final bool isSold;

  final TextStyle textStyle = Styles.title04;

  const CountdownLabel({
    this.endDate,
    this.isSold = false,
  });

  @override
  _CountdownLabelState createState() => _CountdownLabelState();
}

class _CountdownLabelState extends State<CountdownLabel> {
  Timer timer;
  double _textWidth;

  double get textWidth {
    if (_textWidth == null) {
      _textWidth = componentWidth(context);
    }

    return _textWidth;
  }

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

  Widget get timeDifferenceLabel {
    if (widget.isSold || durationUntilEnd.inSeconds <= 0) {
      return Text('Verkauft', style: widget.textStyle);
    }

    if (durationUntilEnd.inHours <= 23) {
      return _durationInHoursMinSecsWidget(context);
    } else if (durationUntilEnd.inHours <= 47) {
      return Text("Noch 1 Tag", style: widget.textStyle);
    } else {
      return Text("Noch ${durationUntilEnd.inDays} Tage",
          style: widget.textStyle);
    }
  }

  String _twoDigits(int n) => n.toString().padLeft(2, "0");

  Widget _durationInHoursMinSecsWidget(BuildContext context) {
    double width = componentWidth(context);
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        componentWidget(_twoDigits(durationUntilEnd.inHours)),
        hoursMinSecSeparator,
        componentWidget(_twoDigits(durationUntilEnd.inMinutes.remainder(60))),
        hoursMinSecSeparator,
        componentWidget(
          _twoDigits(durationUntilEnd.inSeconds.remainder(60)),
          alignment: Alignment.centerLeft,
        ),
      ],
    );
  }

  Widget get hoursMinSecSeparator => Text(
        ':',
        style: widget.textStyle,
      );

  Widget componentWidget(String text,
      {Alignment alignment = Alignment.center}) {
    return Container(
      alignment: alignment,
      width: textWidth,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            text[0],
            style: widget.textStyle,
            textAlign: TextAlign.justify,
          ),
          Text(
            text[1],
            style: widget.textStyle,
            textAlign: TextAlign.justify,
          ),
        ],
      ),
    );
  }

  double componentWidth(BuildContext context) => (TextPainter(
          text: TextSpan(text: "00", style: widget.textStyle),
          maxLines: 1,
          textScaleFactor: MediaQuery.of(context).textScaleFactor,
          textDirection: TextDirection.ltr)
        ..layout())
      .size
      .width;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(7),
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
            durationUntilEnd.inHours <= 12 ? SizedBox(width: 4) : Container(),
            timeDifferenceLabel,
          ],
        ),
      ),
    );
  }
}
