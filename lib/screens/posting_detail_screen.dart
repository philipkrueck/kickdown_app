import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:kickdown_app/Components/countdown_label.dart';
import 'package:kickdown_app/Networking/posting.dart';

class PostingDetailsScreen extends StatelessWidget {
  final Posting posting;

  PostingDetailsScreen({this.posting});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: Column(
        children: [
          Stack(
            children: [
              Image.network(
                posting.heroPhotoURL,
              ),
              Positioned(
                top: 50,
                left: 16,
                height: 30,
                width: 30,
                child: CupertinoNavigationBarBackButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  color: Colors.white,
                ),
              ),
              Positioned(
                  top: 50,
                  right: 16,
                  height: 30,
                  width: 30,
                  child: Icon(Icons.breakfast_dining)),
              Positioned(
                  bottom: 8,
                  right: 8,
                  child: Text(
                    '1/119',
                    style: TextStyle(color: Colors.white),
                  )),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(posting.title),
                    Text(
                      'in ${posting.city}',
                      style: TextStyle(color: Colors.grey, fontSize: 13),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Text('${posting.currentPrice} €',
                        style: TextStyle(
                            color: Colors.red,
                            fontSize: 22,
                            fontWeight: FontWeight.bold)),
                    CountdownLabel(),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(32.0),
            child: ListView(
              shrinkWrap: true, // TODO
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
