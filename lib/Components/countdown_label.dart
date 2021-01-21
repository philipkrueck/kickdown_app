import 'package:flutter/material.dart';

class CountdownLabel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.red,
      child: Padding(
        padding: const EdgeInsets.all(2.0),
        child: Row(
          children: [
            Icon(Icons.timer_sharp, color: Colors.white),
            Text(
              '12:47:55',
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
