import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kickdown_app/models/posting.dart';
import 'package:kickdown_app/styles.dart';

import 'package:kickdown_app/ui/shared/posting_header/posting_header_viewmodel.dart';

import '../countdown_label.dart';

Image placeholderImage = Image.asset(
  'assets/img_placeholder.png',
  fit: BoxFit.cover,
);

class PostingHeader extends StatelessWidget {
  final PostingHeaderViewmodel postingHeaderViewmodel;

  PostingHeader({
    @required this.postingHeaderViewmodel,
  });

  Widget get _networkImage {
    return AspectRatio(
      aspectRatio: 16 / 9,
      child: Container(
        width: double.infinity,
        child: postingHeaderViewmodel.images.first ?? placeholderImage,
      ),
    );
  }

  Widget _buildFavoriteIcon({context, bool isSelected}) {
    return Positioned(
      top: postingHeaderViewmodel.isDetail
          ? MediaQuery.of(context).padding.top + 4
          : 4,
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
        onPressed: postingHeaderViewmodel.onFavoriteTapped,
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
        onPressed: postingHeaderViewmodel.onBackButtonTapped,
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
                    postingHeaderViewmodel.title,
                    style: Styles.title02,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    softWrap: false,
                  ),
                ),
                Text(
                  postingHeaderViewmodel.currentPrice,
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
                  postingHeaderViewmodel.city,
                  style: Styles.caption02,
                ),
                CountdownLabel(
                  endDate: postingHeaderViewmodel.endDate,
                  currentUserIsHighestBidder:
                      postingHeaderViewmodel.currentUserIsHighestBidder,
                )
              ],
            )
          ],
        ),
      );
    }

    return Hero(
      tag: postingHeaderViewmodel.id,
      child: Container(
        color: Colors.white,
        child: Column(
          children: [
            Stack(
              children: [
                _networkImage,
                postingHeaderViewmodel.isDetail
                    ? _buildBackButton(context)
                    : Container(),
                _buildFavoriteIcon(
                  context: context,
                  isSelected:
                      postingHeaderViewmodel.starredByCurrentUser ?? false,
                ),
                postingHeaderViewmodel.isDetail ? _imageLabel : Container(),
              ],
            ),
            _buildBottomInformation(),
          ],
        ),
      ),
    );
  }
}
