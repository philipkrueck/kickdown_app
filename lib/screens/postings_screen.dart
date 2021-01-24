import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kickdown_app/components/posting_card.dart';
import 'package:kickdown_app/model/postings_repository.dart';
import 'package:kickdown_app/networking/posting.dart';

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
        Widget listingsListSliver;
        if (snapshot.hasData) {
          final List<Posting> postings = snapshot.data;
          listingsListSliver = SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return PostingCard(posting: postings[index]);
              },
              childCount: postings.length,
            ),
          );

          _buildListView(snapshot.data);
        } else if (snapshot.hasError) {
          listingsListSliver = SliverToBoxAdapter(
              child: Center(child: Text("${snapshot.error}")));
        } else {
          listingsListSliver = SliverToBoxAdapter(
              child: Center(child: CupertinoActivityIndicator()));
        }
        return CustomScrollView(
          slivers: <Widget>[
            navigationBarSliver,
            SliverSafeArea(
              top: false,
              sliver: listingsListSliver,
            ),
          ],
        );
      },
    );
  }

  Widget _buildListView(List<Posting> postings) {
    return ListView(
      children: postings.map((posting) {
        return PostingCard(posting: posting);
      }).toList(),
    );
  }
}
