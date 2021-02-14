import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kickdown_app/app/locator.dart';
import 'package:kickdown_app/models/posting.dart';
import 'package:kickdown_app/ui/shared/posting_card.dart';
import 'package:kickdown_app/ui/views/error_screen.dart';
import 'package:kickdown_app/ui/views/loading_screen.dart';
import 'package:kickdown_app/ui/views/no_data_screen.dart';
import 'package:kickdown_app/ui/views/postings/postings_viewmodel.dart';
import 'package:stacked/stacked.dart';

class PostingsView extends StatelessWidget {
  Future<List<Posting>> futurePostings;
  final navigationBarSliver = CupertinoSliverNavigationBar(
      largeTitle: Text('Angebote'), transitionBetweenRoutes: true);

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
        builder: (context) => CupertinoPageScaffold(
          child: (() {
            switch (model.loadingState) {
              case LoadingState.loading:
                return _buildScrollView(
                  bodySliver: _buildLoading(context: context),
                  isScrollable: false,
                );
              case LoadingState.data:
                return _buildScrollView(
                  bodySliver: _buildSliverList(
                    postings: model.postings,
                    context: context,
                  ),
                  isScrollable: true,
                );
              case LoadingState.noData:
                return _buildScrollView(
                  bodySliver: _buildNoDataInfo(context: context),
                  isScrollable: false,
                );
              case LoadingState.error:
                return _buildScrollView(
                  bodySliver: _buildErrorInfo(context: context),
                  isScrollable: false,
                );
              default:
                return Center(child: Text('no data'));
            }
          }()),

          // child: FutureBuilder<List<Posting>>(
          //   future: futurePostings,
          //   builder: (context, snapshot) {
          //     Widget postingsListSliver;
          //     bool sliverIsScrollable = false;

          //     if (snapshot.hasData) {
          //       List<Posting> postings = snapshot.data;
          //       if (postings.isEmpty) {
          //         postingsListSliver = _buildNoDataInfo(context: context);
          //       } else {
          //         sliverIsScrollable = true;
          //         postingsListSliver = _buildSliverList(
          //             postings: snapshot.data, context: context);
          //       }
          //     } else if (snapshot.hasError) {
          //       postingsListSliver = _buildErrorInfo(context: context);
          //     } else {
          //       postingsListSliver = _buildLoading(context: context);
          //     }

          //     return _buildScrollView(
          //         bodySliver: postingsListSliver,
          //         isScrollable: sliverIsScrollable);
          //   },
        ),
      ),
    );
  }

  Widget _buildSliverList({List<Posting> postings, BuildContext context}) {
    return SliverPadding(
      padding: const EdgeInsets.only(bottom: _padding),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate(
          (BuildContext context, int index) {
            return Padding(
              padding: EdgeInsets.only(
                left: _padding,
                right: _padding,
                top: _padding,
              ),
              child: PostingCard(
                posting: postings[index],
              ),
            );
          },
          childCount: postings.length,
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

  Widget _buildScrollView({Widget bodySliver, bool isScrollable}) {
    return SafeArea(
      child: CustomScrollView(
        physics: isScrollable
            ? AlwaysScrollableScrollPhysics()
            : NeverScrollableScrollPhysics(),
        slivers: <Widget>[
          CupertinoSliverRefreshControl(
            onRefresh: _refreshData,
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

  Future _refreshData() async {
    await Future.delayed(Duration(seconds: 1));

    // futurePostings = PostingsService.loadPostings();
    print('refreshing');
  }
}
