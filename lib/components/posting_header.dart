import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kickdown_app/networking/posting.dart';

import 'countdown_label.dart';

class PostingHeader extends StatelessWidget {
  final Posting posting;
  final bool isDetail;

  PostingHeader({this.posting, this.isDetail = false});

  Widget _buildNetworkImage(Posting posting, bool isDetail) {
    return Image.network(
      posting.heroPhotoURL,
      height: isDetail ? 300 : 180,
      width: double.infinity,
      fit: BoxFit.cover,
      loadingBuilder: (context, child, progress) {
        return progress == null
            ? child
            : CupertinoActivityIndicator.partiallyRevealed();
      },
    );
  }

  Widget _buildFavoriteIcon() {
    return Positioned(
      top: 16,
      right: 16,
      child: Icon(
        Icons.dialer_sip,
        color: Colors.white,
      ),
    );
  }

  Widget _buildCountdownLabel() {
    return Positioned(
      bottom: 8,
      right: 8,
      child: CountdownLabel(),
    );
  }

  Widget _buildBackButton(context) {
    return Positioned(
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
    );
  }

  Widget _buildImageLabel() {
    return Positioned(
      bottom: 8,
      right: 8,
      child: Text(
        '1/119',
        style: TextStyle(color: Colors.white),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            _buildNetworkImage(posting, isDetail),
            isDetail ? _buildBackButton(context) : Container(),
            _buildFavoriteIcon(),
            isDetail ? _buildImageLabel() : _buildCountdownLabel(),
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      posting.title,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      softWrap: false,
                    ),
                    Text('In ${posting.city}'),
                  ],
                ),
              ),
              SizedBox(width: 8),
              Column(
                children: [
                  Text(
                    '${posting.currentPrice} €',
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  isDetail ? CountdownLabel() : Container(),
                ],
              )
            ],
          ),
        ),
      ],
    );
  }
}
