import 'package:flutter/material.dart';

class GradientView extends StatelessWidget {
  final Widget child;
  final double height;

  const GradientView({
    @required this.child,
    this.height = double.infinity,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        child,
        Container(
          height: height,
          decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [Colors.black.withAlpha(117), Colors.transparent]),
          ),
        ),
      ],
    );
  }
}
