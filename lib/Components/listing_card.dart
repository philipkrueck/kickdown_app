import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kickdown_app/Networking/posting.dart';
import 'package:kickdown_app/screens/posting_detail_screen.dart';

import 'countdown_label.dart';

class ListingCard extends StatelessWidget {
  Posting posting;

  ListingCard({this.posting});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // potentially use something else here to avoid applying button styles to card
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          height: 250,
          child: Card(
            child: Column(
              children: [
                Stack(
                  children: [
                    Image.network(
                      posting.heroPhotoURL,
                      height: 180,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      loadingBuilder: (context, child, progress) {
                        return progress == null
                            ? child
                            : CupertinoActivityIndicator.partiallyRevealed();
                      },
                    ),
                    Positioned(
                      top: 16,
                      right: 16,
                      child: Icon(
                        Icons.dialer_sip,
                        color: Colors.white,
                      ),
                    ),
                    Positioned(
                      bottom: 8,
                      right: 8,
                      child: CountdownLabel(),
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(posting.title),
                          Text('In ${posting.city}'),
                        ],
                      ),
                      Text(
                        '${posting.currentPrice} €',
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      onTap: () {
        Navigator.of(context).push(
          CupertinoPageRoute(builder: (context) {
            return PostingDetailsScreen(posting: posting);
          }),
        );
      },
    );
  }
}
