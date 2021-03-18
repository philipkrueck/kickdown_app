import 'package:flutter/cupertino.dart';
import 'package:kickdown_app/styles.dart';

class HighestBidderBadge extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        color: Styles.annotationBadgeColor,
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(8, 3, 7, 2),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(width: 4),
            const Text(
              'Sie sind Höchstbietender',
              style: Styles.title04,
            ),
          ],
        ),
      ),
    );
  }
}
