import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kickdown_app/components/posting_card.dart';
import 'package:kickdown_app/model/postings_repository.dart';
import 'package:kickdown_app/networking/posting.dart';
import 'package:kickdown_app/screens/error_screen.dart';
import 'package:kickdown_app/screens/loading_screen.dart';
import 'package:kickdown_app/screens/no_data_screen.dart';

class PostingsScreen extends StatefulWidget {
  @override
  _PostingsScreenState createState() => _PostingsScreenState();
}

class _PostingsScreenState extends State<PostingsScreen> {
  Future<List<Posting>> futurePostings;
  final navigationBarSliver = CupertinoSliverNavigationBar(
      largeTitle: Text('Angebote'), transitionBetweenRoutes: true);

  @override
  void initState() {
    super.initState();
    futurePostings = PostingsRepository.loadPostings();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Posting>>(
      future: futurePostings,
      builder: (context, snapshot) {
        Widget postingsListSliver;
        bool sliverIsScrollable = false;

        if (snapshot.hasData) {
          List<Posting> postings = snapshot.data;
          if (postings.isEmpty) {
            postingsListSliver = _buildNoDataInfo(context: context);
          } else {
            sliverIsScrollable = true;
            postingsListSliver =
                _buildSliverList(postings: snapshot.data, context: context);
          }
        } else if (snapshot.hasError) {
          postingsListSliver = _buildErrorInfo(context: context);
        } else {
          postingsListSliver = _buildLoading(context: context);
        }

        return _buildScrollView(
            bodySliver: postingsListSliver, isScrollable: sliverIsScrollable);
      },
    );
  }

  Widget _buildSliverList({List<Posting> postings, BuildContext context}) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          return PostingCard(posting: postings[index]);
        },
        childCount: postings.length,
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
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom),
        child: ErrorScreen(),
      ),
    );
  }

  CustomScrollView _buildScrollView({Widget bodySliver, bool isScrollable}) {
    return CustomScrollView(
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
    );
  }

  Future _refreshData() async {
    await Future.delayed(Duration(seconds: 1));

    futurePostings = PostingsRepository.loadPostings();
    print('refreshing');

    setState(() {});
  }
}
