import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kickdown_app/models/posting.dart';
import 'package:kickdown_app/ui/shared/buttons/button_01.dart';
import 'package:kickdown_app/ui/shared/posting_header.dart';

import 'bid_preparation_screen.dart';

class PostingDetailsScreen extends StatelessWidget {
  final Posting posting;

  PostingDetailsScreen({this.posting});

  @override
  Widget build(BuildContext context) {
    void _onButtonPressed() {
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

    return CupertinoPageScaffold(
      child: Column(
        children: [
          PostingHeader(posting: posting, isDetail: true),
          Expanded(
            child: ListView(
              padding: EdgeInsets.symmetric(vertical: 8, horizontal: 32),
              shrinkWrap: true,
              children: [
                Text(
                  'Details',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                Column(
                  children: [
                    DetailRow(type: 'Verkäufer', detail: posting.sellerName),
                    DetailRow(type: 'Hersteller', detail: posting.carMake),
                    DetailRow(type: 'Modell', detail: posting.carModel),
                    DetailRow(type: 'Baujahr', detail: '${posting.carYear}'),
                    DetailRow(type: 'Farbe', detail: posting.color),
                    DetailRow(type: 'Kilometerstand', detail: posting.milage),
                    DetailRow(type: 'Getriebe', detail: posting.transmission),
                    DetailRow(type: 'Länderversion', detail: posting.country),
                  ],
                ),
                SizedBox(height: 30),
                Text(
                  'Beschreibung',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 20),
                Text(
                  posting.description,
                ),
              ],
            ),
          ),
          Container(
            height: 70,
            width: double.infinity,
            padding: EdgeInsets.symmetric(vertical: 8, horizontal: 32),
            child: Expanded(
                child: Button01(
              onPressed: _onButtonPressed,
              text: 'Bieten',
            )),
          ),
          SizedBox(height: MediaQuery.of(context).padding.bottom)
        ],
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
        Text(type, style: TextStyle(fontWeight: FontWeight.w300)),
        Text(detail, style: TextStyle(color: Colors.grey)),
      ],
    );
  }
}
