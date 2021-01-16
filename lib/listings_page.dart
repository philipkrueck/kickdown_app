import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class ListingsPage extends StatefulWidget {
  @override
  _ListingsPageState createState() => _ListingsPageState();
}

class _ListingsPageState extends State<ListingsPage> {
  @override
  Widget build(BuildContext context) {
    return CupertinoTabView(
      builder: (BuildContext context) {
        return CupertinoPageScaffold(
          navigationBar: CupertinoNavigationBar(
            middle: Text('Angebote'),
          ),
          child: ListView(
            children: [
              ListingCard(),
              ListingCard(),
              ListingCard(),
              ListingCard(),
            ],
          ),
        );
      },
    );
  }
}

class ListingCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        height: 250,
        child: Card(
          child: Column(
            children: [
              Container(
                height: 180,
                color: Colors.grey,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('BMW 3.0 CSi E9'),
                        Text('In Hamburg'),
                      ],
                    ),
                    Text(
                      '38.970 €',
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
    );
  }
}
