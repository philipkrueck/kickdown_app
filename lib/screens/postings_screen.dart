import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:kickdown_app/Components/listing_card.dart';
import 'package:kickdown_app/Networking/network_layer.dart';
import 'package:kickdown_app/Networking/posting.dart';
import 'package:kickdown_app/screens/posting_detail_screen.dart';

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
    futurePostings = NetworkLayer.fetchPostings();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoTabView(
      builder: (BuildContext context) {
        return CupertinoPageScaffold(
          child: FutureBuilder<List<Posting>>(
            future: futurePostings,
            builder: (context, snapshot) {
              Widget listingsListSliver;
              if (snapshot.hasData) {
                final List<Posting> postings = snapshot.data;
                listingsListSliver = SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                      return ListingCard(posting: postings[index]);
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

              print(listingsListSliver);

              return CustomScrollView(
                slivers: [
                  navigationBarSliver,
                  listingsListSliver,
                ],
              );
            },
          ),
        );
      },
    );
  }

  Widget _buildListView(List<Posting> postings) {
    return ListView(
      children: postings.map((posting) {
        return ListingCard(posting: posting);
      }).toList(),
    );
  }
}
