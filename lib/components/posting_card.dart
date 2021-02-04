import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kickdown_app/components/posting_header.dart';
import 'package:kickdown_app/networking/posting.dart';
import 'package:kickdown_app/screens/posting_detail_screen.dart';

import 'countdown_label.dart';

class PostingCard extends StatelessWidget {
  Posting posting;

  PostingCard({this.posting});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // potentially use something else here to avoid applying button styles to card
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Color(0x54000000),
                spreadRadius: 1,
                blurRadius: 4,
              ),
            ],
            borderRadius: BorderRadius.circular(20),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: PostingHeader(posting: posting),
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
