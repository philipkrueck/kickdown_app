import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kickdown_app/networking/posting.dart';
import 'package:kickdown_app/styles.dart';

import '../application_state.dart';
import 'countdown_label.dart';
import 'package:intl/intl.dart';

class PostingHeader extends StatelessWidget {
  final Posting posting;
  final bool isDetail;

  final NumberFormat currencyFormatter =
      NumberFormat.simpleCurrency(locale: 'eu', decimalDigits: 0);

  PostingHeader({this.posting, this.isDetail = false});

  Widget get _networkImage {
    return CachedNetworkImage(
      imageUrl: this.posting.heroPhotoURL,
      placeholder: (context, url) => ApplicationState.placeholder,
      errorWidget: (context, url, error) => Icon(Icons.error),
      width: double.infinity,
      height: isDetail ? 300 : 180,
      fit: BoxFit.fitWidth,
    );
  }

  Widget _buildFavoriteIcon(context) {
    return Positioned(
      top: isDetail ? MediaQuery.of(context).padding.top + 8 : 8,
      right: 16,
      child: Icon(
        Icons.dialer_sip,
        color: Colors.white,
      ),
    );
  }

  Widget _buildBackButton(context) {
    return Positioned(
      top: MediaQuery.of(context).padding.top + 8,
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

  Widget get _imageLabel {
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
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          Stack(
            children: [
              _networkImage,
              isDetail ? _buildBackButton(context) : Container(),
              _buildFavoriteIcon(context),
              isDetail ? _imageLabel : Container(),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Text(
                        posting.title,
                        style: Styles.title02,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        softWrap: false,
                      ),
                    ),
                    Text(
                      currencyFormatter.format(posting.currentPrice),
                      style: Styles.title03,
                    ),
                  ],
                ),
                SizedBox(height: 5),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      posting.city,
                      style: Styles.caption02,
                    ),
                    CountdownLabel(
                      endDate: posting.endTime,
                      currentUserIsHighestBidder: false,
                    )
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
