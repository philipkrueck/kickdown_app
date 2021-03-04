import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kickdown_app/styles.dart';
import 'package:kickdown_app/ui/shared/buttons/button_01.dart';
import 'package:kickdown_app/ui/shared/posting_header/posting_header.dart';
import 'package:kickdown_app/ui/views/posting_detail/posting_detail_viewmodel.dart';
import 'package:stacked/stacked.dart';

class PostingDetailView extends StatefulWidget {
  final PostingDetailViewmodel postingDetailViewmodel;

  PostingDetailView({this.postingDetailViewmodel}) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: Colors.white),
    );
  }

  @override
  _PostingDetailViewState createState() => _PostingDetailViewState();
}

class _PostingDetailViewState extends State<PostingDetailView> {
  /// Builds this widget with it's own context and configuration
  /// This allows the background to be interactive and depict live state
  Widget get $thisWidget => build(context);

  @override
  Widget build(BuildContext buildContext) {
    return ViewModelBuilder<PostingDetailViewmodel>.reactive(
      viewModelBuilder: () => widget.postingDetailViewmodel,
      initialiseSpecialViewModelsOnce: true,
      disposeViewModel: false,
      fireOnModelReadyOnce: true,
      builder: (modelContext, model, child) =>
          AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: CupertinoPageScaffold(
          resizeToAvoidBottomInset: false,
          child: Column(
            children: [
              GestureDetector(
                child: PostingHeader(
                  postingHeaderViewmodel: model.postingHeaderViewmodel,
                ),
                onTap: model.onPostingHeaderTapped,
              ),
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
                    onPressed: () => model.onCTAButtonPressed(
                        context: buildContext,
                        behindChildContext: this.context,
                        behindChild: this.widget),
                    text: 'Bieten',
                  ),
                ),
              ),
              SizedBox(height: MediaQuery.of(modelContext).padding.bottom)
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
