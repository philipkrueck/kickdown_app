import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kickdown_app/styles.dart';
import 'package:kickdown_app/ui/shared/buttons/button_01.dart';
import 'package:kickdown_app/ui/shared/buttons/close_view_button.dart';
import 'package:kickdown_app/ui/shared/countdown_label.dart';
import 'package:kickdown_app/ui/shared/kickdown_textfield.dart';
import 'package:kickdown_app/ui/views/bid_preparation_view/bid_preparation_viewmodel.dart';
import 'package:stacked/stacked.dart';

class BidPreparationView extends StatelessWidget {
  final BidPreparationViewmodel viewmodel;

  const BidPreparationView({this.viewmodel});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<BidPreparationViewmodel>.reactive(
      viewModelBuilder: () => viewmodel,
      builder: (context, model, child) => SafeArea(
        bottom: false,
        child: GestureDetector(
          onTap: () {
            print('tap');
            FocusScopeNode currentFocus = FocusScope.of(context);

            if (!currentFocus.hasPrimaryFocus) {
              currentFocus.unfocus();
            }
          },
          child: CupertinoPageScaffold(
            backgroundColor: Colors.transparent,
            child: Container(
              height: 307,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  ),
                  color: Colors.white),
              child: Padding(
                padding: EdgeInsets.fromLTRB(16, 16, 16, 8),
                child: Stack(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CloseViewButton(
                              color: Colors.black,
                              onPressed: () =>
                                  model.closeDialog(context: context),
                            ),
                            CountdownLabel(
                              endDate: model.endDate,
                            ),
                            CloseViewButton(
                              color: Colors.transparent,
                            ),
                          ],
                        ), // ),
                        Text(
                          'Aktuelles Gebot',
                          style: Styles.caption01,
                        ),
                        SizedBox(
                          height: 3,
                        ),
                        Text(model.price, style: Styles.title03),
                        // HighestBidderBadge(),
                        SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          height: 23, // mocking the HighestBidderBadge
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        Container(
                          height: 50,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Expanded(
                                flex: 3,
                                child: KickdownTextField(
                                    isInvalid: !model.textInputIsValid,
                                    onInputTextChanged:
                                        model.onInputTextChanged),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                flex: 2,
                                child: Material(
                                  child: Button01(
                                    onPressed: () => model.onBidButtonPressed(
                                        context: context),
                                    text: 'Bieten',
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                            'Mit der Abgabe meines Angebotes erkläre ich mich mit den geltenden Nutzungsbedingungen einverstanden.',
                            style: Styles.caption01,
                            textAlign: TextAlign.center),
                      ],
                    ),
                    Positioned(
                      left: 0,
                      top: 0,
                      child: Container(),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
