import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kickdown_app/styles.dart';
import 'package:kickdown_app/ui/shared/posting_header/gradient_view.dart';

import 'package:kickdown_app/ui/shared/posting_header/posting_header_viewmodel.dart';
import 'package:stacked/stacked.dart';

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

  Widget _buildNetworkImage({Image image}) {
    return AspectRatio(
      aspectRatio: 16 / 9,
      child: Container(
        height: double.infinity,
        width: double.infinity,
        child: image ?? placeholderImage,
      ),
    );
  }

  Widget _buildGallery(
      {BuildContext context,
      List<Image> images,
      Function setGalleryIndex,
      CarouselController carouselController}) {
    return CarouselSlider.builder(
      carouselController: carouselController,
      options: CarouselOptions(
        scrollDirection: Axis.horizontal,
        enableInfiniteScroll: false,
        initialPage: 0,
        viewportFraction: 1,
        onPageChanged: (int index, _) {
          setGalleryIndex(index);
        },
      ),
      itemCount: images.length,
      itemBuilder: (BuildContext context, int index, int realIndex) {
        return GradientView(
          child: Container(
            width: double.infinity,
            child: AspectRatio(
              aspectRatio: 16 / 9,
              child: images[realIndex] ?? placeholderImage,
            ),
          ),
          height: MediaQuery.of(context).size.width * 9 / 16 * 0.38,
        );
      },
    );
  }

  Widget _buildFavoriteIcon(
      {BuildContext context,
      bool isSelected,
      bool isDetail,
      Function onFavoriteTapped}) {
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

  Widget _buildBackButton({BuildContext context, Function onButtonTapped}) {
    return Positioned(
      top: MediaQuery.of(context).padding.top + 4,
      left: 12,
      child: CupertinoButton(
        padding: EdgeInsets.zero,
        child: Image.asset(
          'assets/ic_navbar_back.png',
          color: Colors.white,
          height: 30,
        ),
        onPressed: onButtonTapped,
      ),
    );
  }

  Widget _imageLabel({int currElement, int totalElements}) {
    return Positioned(
      bottom: 12,
      right: 12,
      child: Text(
        '$currElement/$totalElements',
        style: Styles.caption04,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<PostingHeaderViewmodel>.reactive(
      viewModelBuilder: () => postingHeaderViewmodel,
      disposeViewModel: false,
      builder: (context, model, child) => Hero(
        tag: model.id,
        child: Container(
          color: Colors.white,
          child: Column(
            children: [
              Stack(
                children: [
                  model.shouldShowGallery
                      ? _buildGallery(
                          context: context,
                          images: model.images,
                          setGalleryIndex: model.setCurrentIndex,
                          carouselController: model.carouselController,
                        )
                      : _buildNetworkImage(
                          image:
                              model.images != null ? model.images.first : null),
                  model.isDetail
                      ? _buildBackButton(
                          context: context,
                          onButtonTapped: () =>
                              model.onBackButtonTapped(context: context),
                        )
                      : Container(),
                  model.shouldShowFavorite
                      ? _buildFavoriteIcon(
                          context: context,
                          isSelected: model.starredByCurrentUser,
                          isDetail: model.isDetail,
                          onFavoriteTapped: model.onFavoriteTapped,
                        )
                      : Container(),
                  model.shouldShowGallery
                      ? _imageLabel(
                          currElement: model.currentIndex + 1,
                          totalElements: model.totalImages)
                      : Container(),
                ],
              ),
              Container(
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
                            model.title,
                            style: Styles.title02,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            softWrap: false,
                          ),
                        ),
                        Text(
                          model.currentPrice,
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
                          model.city,
                          style: Styles.caption02,
                        ),
                        CountdownLabel(
                          endDate: model.endDate,
                          isSold: false, // todo: add
                        )
                      ],
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
