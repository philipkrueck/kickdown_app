import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kickdown_app/components/countdown_label.dart';
import 'package:kickdown_app/components/posting_header.dart';
import 'package:kickdown_app/networking/posting.dart';

class PostingDetailsScreen extends StatelessWidget {
  final Posting posting;

  PostingDetailsScreen({this.posting});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: Column(
        children: [
          PostingHeader(posting: posting, isDetail: true),
          Padding(
            padding: const EdgeInsets.all(32.0),
            child: ListView(
              shrinkWrap: true,
              children: [
                Text(
                  'Details',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 20),
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
          FlatButton(
            onPressed: () {
              print('Bieten');
            },
            child: Text(
              'Bieten',
              style: TextStyle(color: Colors.white),
            ),
            color: CupertinoTheme.of(context).primaryColor,
          )
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
