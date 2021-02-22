import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kickdown_app/app/locator.dart';
import 'package:kickdown_app/models/posting.dart';
import 'package:kickdown_app/ui/shared/posting_card.dart';
import 'package:kickdown_app/ui/views/error_screen.dart';
import 'package:kickdown_app/ui/views/loading_screen.dart';
import 'package:kickdown_app/ui/views/no_data_screen.dart';
import 'package:kickdown_app/ui/views/postings/postings_viewmodel.dart';
import 'package:stacked/stacked.dart';

class PostingsView extends StatelessWidget {
  final navigationBarSliver = CupertinoSliverNavigationBar(
    largeTitle: Text('Angebote'),
    transitionBetweenRoutes: true,
  );

  static const double _padding = 16.0;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<PostingsViewmodel>.reactive(
      viewModelBuilder: () => locator<PostingsViewmodel>(),
      onModelReady: (model) => model.initialize(),
      fireOnModelReadyOnce: true,
      disposeViewModel: false,
      initialiseSpecialViewModelsOnce: true,
      builder: (context, model, child) => CupertinoTabView(
        builder: (context) => AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle.dark,
          child: CupertinoPageScaffold(
            child: (() {
              switch (model.loadingState) {
                case LoadingState.loading:
                  return _buildScrollView(
                    bodySliver: _buildLoading(context: context),
                    isScrollable: false,
                    onRefresh: model.refreshPostings,
                  );
                case LoadingState.data:
                  return _buildScrollView(
                    bodySliver: _buildSliverList(
                      context: context,
                      postingsViewmodel: model,
                    ),
                    isScrollable: true,
                    onRefresh: model.refreshPostings,
                  );
                case LoadingState.noData:
                  return _buildScrollView(
                    bodySliver: _buildNoDataInfo(context: context),
                    isScrollable: false,
                    onRefresh: model.refreshPostings,
                  );
                case LoadingState.error:
                  return _buildScrollView(
                    bodySliver: _buildErrorInfo(context: context),
                    isScrollable: false,
                    onRefresh: model.refreshPostings,
                  );
                default:
                  return _buildScrollView(
                    bodySliver: _buildNoDataInfo(context: context),
                    isScrollable: false,
                    onRefresh: model.refreshPostings,
                  );
              }
            }()),
          ),
        ),
      ),
    );
  }

  Widget _buildSliverList({
    PostingsViewmodel postingsViewmodel,
    BuildContext context,
  }) {
    return SliverPadding(
      padding: const EdgeInsets.only(
        bottom: _padding,
        left: _padding,
        right: _padding,
      ),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate(
          (BuildContext context, int index) {
            return Padding(
              padding: EdgeInsets.only(
                top: _padding,
              ),
              child: PostingCard(
                postingHeaderViewmodel:
                    postingsViewmodel.headerViewmodel(index: index),
                onTap: () => postingsViewmodel.handleTapOnItem(
                    index: index, context: context),
              ),
            );
          },
          childCount: postingsViewmodel.postingCardCount,
        ),
      ),
    );
  }

  Widget _buildLoading({BuildContext context}) {
    return _buildInfoContainer(child: LoadingScreen(), context: context);
  }

  Widget _buildNoDataInfo({BuildContext context}) {
    return _buildInfoContainer(child: NoDataScreen(), context: context);
  }

  Widget _buildErrorInfo({BuildContext context}) {
    return _buildInfoContainer(child: ErrorScreen(), context: context);
  }

  Widget _buildInfoContainer({Widget child, BuildContext context}) {
    return SliverFillRemaining(
      hasScrollBody: false,
      child: Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).padding.bottom,
        ),
        child: child,
      ),
    );
  }

  Widget _buildScrollView(
      {Widget bodySliver, bool isScrollable, Function onRefresh}) {
    return SafeArea(
      child: CustomScrollView(
        physics: isScrollable
            ? AlwaysScrollableScrollPhysics()
            : NeverScrollableScrollPhysics(),
        slivers: <Widget>[
          CupertinoSliverRefreshControl(
            onRefresh: () async {
              await Future.delayed(Duration(seconds: 1));
              onRefresh();
            },
          ),
          navigationBarSliver,
          SliverSafeArea(
            top: false,
            sliver: bodySliver,
          ),
        ],
      ),
    );
  }
}
