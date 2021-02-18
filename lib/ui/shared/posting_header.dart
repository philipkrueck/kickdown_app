import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kickdown_app/models/posting.dart';
import 'package:kickdown_app/styles.dart';

import 'countdown_label.dart';
import 'package:intl/intl.dart';

Image placeholderImage = Image.asset(
  'assets/img_placeholder.png',
  fit: BoxFit.cover,
);

class PostingHeader extends StatelessWidget {
  final Posting posting;
  final bool isDetail;
  final Function onFavoriteTapped;
  final Function onBackButtonTapped;
  final Function onTap;

  final NumberFormat currencyFormatter =
      NumberFormat.simpleCurrency(locale: 'eu', decimalDigits: 0);

  PostingHeader({
    @required this.posting,
    this.isDetail = false,
    this.onFavoriteTapped,
    this.onBackButtonTapped,
    this.onTap,
  });

  Widget get _networkImage {
    return AspectRatio(
      aspectRatio: 16 / 9,
      child: CachedNetworkImage(
        imageUrl: this.posting.heroPhotoURL,
        placeholder: (context, url) => placeholderImage,
        errorWidget: (context, url, error) => placeholderImage,
        width: double.infinity,
        fit: BoxFit.fitWidth,
      ),
    );
  }

  Widget _buildFavoriteIcon({context, bool isSelected}) {
    return Positioned(
      top: isDetail ? MediaQuery.of(context).padding.top + 4 : 4,
      right: 16,
      child: CupertinoButton(
        padding: EdgeInsets.zero,
        child: Image.asset(
          isSelected
              ? 'assets/ic_favorite_selected.png'
              : 'assets/ic_favorite_normal.png',
          width: 32,
          height: 32,
        ),
        onPressed: onFavoriteTapped,
      ),
    );
  }

  Widget _buildBackButton(context) {
    return Positioned(
      top: MediaQuery.of(context).padding.top + 4,
      left: 16,
      height: 30,
      width: 30,
      child: CupertinoNavigationBarBackButton(
        onPressed: onBackButtonTapped,
        color: Colors.white,
      ),
    );
  }

  Widget get _imageLabel {
    return Positioned(
      bottom: 12,
      right: 12,
      child: Text(
        '1/119',
        style: Styles.caption04,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget _buildBottomInformation() {
      return Container(
        padding: EdgeInsets.all(8.0),
        color: Colors.white,
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
            SizedBox(height: 4),
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
      );
    }

    return Hero(
      tag: posting.id,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          color: Colors.white,
          child: Column(
            children: [
              Stack(
                children: [
                  _networkImage,
                  isDetail ? _buildBackButton(context) : Container(),
                  _buildFavoriteIcon(
                    context: context,
                    isSelected: posting.starredByCurrentUser ?? false,
                  ),
                  isDetail ? _imageLabel : Container(),
                ],
              ),
              _buildBottomInformation(),
            ],
          ),
        ),
      ),
    );
  }
}
