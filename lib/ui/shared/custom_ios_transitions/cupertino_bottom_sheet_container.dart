import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kickdown_app/ui/shared/custom_ios_transitions/cupertino_dialog_body.dart';

/// Inspiration taken from [modal_bottom_sheet](https://github.com/jamesblasco/modal_bottom_sheet)
class CupertinoBottomSheetContainer extends StatelessWidget {
  /// Widget to render
  final Widget child;
  final Color backgroundColor;

  /// Add padding to the top of [child], this is also the height of visible
  /// content behind [child]
  ///
  /// Defaults to 10
  final double topPadding;
  const CupertinoBottomSheetContainer(
      {this.child, this.backgroundColor, this.topPadding = 10})
      : assert(topPadding != null);

  @override
  Widget build(BuildContext context) {
    final topPadding = this.topPadding;
    print('topPadding: $topPadding');
    final radius = Radius.circular(10);
    final shadow =
        BoxShadow(blurRadius: 10, color: Colors.black12, spreadRadius: 5);

    final decoration =
        BoxDecoration(color: this.backgroundColor, boxShadow: [shadow]);

    return Padding(
      padding: EdgeInsets.only(
          top: topPadding - MediaQuery.of(context).padding.vertical),
      child: ClipRRect(
        borderRadius: BorderRadius.only(topLeft: radius, topRight: radius),
        child: Container(
          decoration: decoration,
          width: double.infinity,
          child: child,
        ),
      ),
    );
  }
}
