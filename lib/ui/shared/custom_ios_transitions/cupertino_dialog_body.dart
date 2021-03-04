import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kickdown_app/ui/shared/custom_ios_transitions/cupertino_bottom_sheet_container.dart';

class CupertinoDialogBody extends StatefulWidget {
  final double height;
  final Widget child;

  const CupertinoDialogBody({this.height, this.child});

  @override
  CupertinoDialogBodyState createState() => CupertinoDialogBodyState();
}

class CupertinoDialogBodyState extends State<CupertinoDialogBody> {
  /// Prevent further popping of navigator stack once dialog is popped
  bool isDialogPopped = false;

  double get screenHeight =>
      MediaQuery.of(this.context).size.height +
      MediaQuery.of(context).padding.vertical;

  double get relativeDialogHeight => widget.height / screenHeight;

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      /// Only allow to be scrolled down up to half size of the child
      minChildSize: 0.9 * relativeDialogHeight,

      /// Show full screen by default
      initialChildSize: 1,
      builder: (context, controller) {
        print('proposed top padding: ${screenHeight - widget.height}');

        return CupertinoBottomSheetContainer(
          backgroundColor: Colors.white,
          topPadding: screenHeight - widget.height,
          child: NotificationListener<DraggableScrollableNotification>(
            onNotification: (DraggableScrollableNotification notification) {
              print('minExtent ${notification.minExtent}');
              print('extent ${relativeDialogHeight * notification.extent}');
              if (!isDialogPopped &&
                  relativeDialogHeight * notification.extent <=
                      notification.minExtent) {
                print('popping');
                isDialogPopped = true;
                Navigator.of(context).pop();
              }
              return false;
            },
            child: CupertinoApp(
              debugShowCheckedModeBanner: false,
              home: CustomScrollView(
                controller: controller,
                shrinkWrap: false,
                slivers: [
                  SliverFillRemaining(child: widget.child),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
