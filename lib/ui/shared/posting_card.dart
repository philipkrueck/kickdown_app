import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kickdown_app/ui/shared/posting_header/posting_header.dart';
import 'package:kickdown_app/ui/shared/posting_header/posting_header_viewmodel.dart';

class PostingCard extends StatelessWidget {
  final PostingHeaderViewmodel postingHeaderViewmodel;
  final Function onTap;

  PostingCard({@required this.postingHeaderViewmodel, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // potentially use something else here to avoid applying button styles to card
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              spreadRadius: 0,
              blurRadius: 20,
            ),
          ],
          borderRadius: BorderRadius.circular(8),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: PostingHeader(
            postingHeaderViewmodel: postingHeaderViewmodel,
          ),
        ),
      ),
      onTap: () => onTap(),
    );
  }
}
