import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kickdown_app/styles.dart';
import 'package:kickdown_app/ui/shared/buttons/button_01.dart';
import 'package:kickdown_app/ui/shared/posting_header.dart';
import 'package:kickdown_app/ui/views/bid_preparation_screen.dart';
import 'package:kickdown_app/ui/views/posting_detail/posting_detail_viewmodel.dart';
import 'package:stacked/stacked.dart';

class PostingDetailView extends StatelessWidget {
  final PostingDetailViewmodel postingDetailViewmodel;

  PostingDetailView({this.postingDetailViewmodel}) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: Colors.white),
    );
  }

  @override
  Widget build(BuildContext context) {
    void _onButtonPressed() {
      // TODO: this popup should triggered via the view model
      showCupertinoModalPopup(
          useRootNavigator: true,
          context: context,
          builder: (context) {
            return Container(
              decoration: BoxDecoration(
                  color: Theme.of(context).canvasColor,
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(16))),
              width: double.infinity,
              height: 300,
              child: BidPreparationScreen(),
            );
          });
    }

    return ViewModelBuilder<PostingDetailViewmodel>.nonReactive(
      viewModelBuilder: () => postingDetailViewmodel,
      builder: (context, model, child) => AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: CupertinoPageScaffold(
          child: Column(
            children: [
              PostingHeader(
                posting: model.posting,
                isDetail: true,
                onBackButtonTapped: () =>
                    model.onBackButtonTapped(context: context),
                onFavoriteTapped: model.onFavoriteTapped,
                onTap: model.onPostingHeaderTapped,
              ), // NOTE: the posting probably shouldn't be exposed like this to the PostingHeader widget
              Expanded(
                child: ListView(
                  padding: EdgeInsets.fromLTRB(38, 8, 38, 12),
                  shrinkWrap: true,
                  children: [
                    Text(
                      'Details',
                      style: Styles.title02,
                    ),
                    SizedBox(height: 6),
                    Wrap(
                      runSpacing: 5,
                      children: model.detailInformation
                          .map((detailInfo) => DetailRow(
                              type: detailInfo.item1, detail: detailInfo.item2))
                          .toList(),
                    ),
                    SizedBox(height: 26),
                    Text(
                      'Beschreibung',
                      style: Styles.title02,
                    ),
                    SizedBox(height: 8),
                    Text(
                      model.description,
                      style: Styles.body01,
                    ),
                  ],
                ),
              ),
              Container(
                width: double.infinity,
                padding: EdgeInsets.fromLTRB(38, 12, 38, 12),
                child: Container(
                  height: 50,
                  child: Button01(
                    onPressed: _onButtonPressed,
                    text: 'Bieten',
                  ),
                ),
              ),
              SizedBox(height: MediaQuery.of(context).padding.bottom)
            ],
          ),
        ),
      ),
    );
  }
}

class DetailRow extends StatelessWidget {
  final String type;
  final String detail;

  DetailRow({this.type, this.detail});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(type, style: Styles.caption02),
        SizedBox(width: 4),
        Text(
          detail,
          style: Styles.caption01,
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
          softWrap: false,
        ),
      ],
    );
  }
}
