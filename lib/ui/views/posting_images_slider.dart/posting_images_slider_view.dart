import 'package:flutter/cupertino.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:kickdown_app/styles.dart';
import 'package:kickdown_app/ui/shared/posting_header/posting_header.dart';
import 'package:kickdown_app/ui/views/posting_images_slider.dart/posting_images_slider_viewmodel.dart';
import 'package:stacked/stacked.dart';

class PostingImagesSliderView extends StatelessWidget {
  static const imageURLs = [
    'https://www.kickdown.com/rails/active_storage/blobs/eyJfcmFpbHMiOnsibWVzc2FnZSI6IkJBaHBBZ1l1IiwiZXhwIjpudWxsLCJwdXIiOiJibG9iX2lkIn19--4857d17bf70a2b3f4b561e6aa7c568c9b95232bb/WhatsApp%20Image%202021-02-08%20at%2020.03.53.jpg',
    'https://www.kickdown.com/rails/active_storage/blobs/eyJfcmFpbHMiOnsibWVzc2FnZSI6IkJBaHBBZ2N1IiwiZXhwIjpudWxsLCJwdXIiOiJibG9iX2lkIn19--5595f05b48bc6af087133adb03a1185cc768dd28/WhatsApp%20Image%202021-02-08%20at%2020.03.55.jpg',
    'https://www.kickdown.com/rails/active_storage/blobs/eyJfcmFpbHMiOnsibWVzc2FnZSI6IkJBaHBBaDR1IiwiZXhwIjpudWxsLCJwdXIiOiJibG9iX2lkIn19--08df8f9cfc8136b186bbcfc905233dd83e4c3e4c/SAM_7867.jpg',
  ];

  final PostingImagesSliderViewmodel postingImagesSliderViewmodel;

  const PostingImagesSliderView({@required this.postingImagesSliderViewmodel});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<PostingImagesSliderViewmodel>.reactive(
      initialiseSpecialViewModelsOnce: true,
      viewModelBuilder: () => postingImagesSliderViewmodel,
      builder: (context, model, child) => CupertinoPageScaffold(
        backgroundColor: Colors.black,
        child: Stack(
          children: [
            Center(
              child: CarouselSlider.builder(
                options: CarouselOptions(
                  height: MediaQuery.of(context).size.height * 0.38,
                  scrollDirection: Axis.horizontal,
                  enableInfiniteScroll: false,
                  initialPage: 0,
                  viewportFraction: 1,
                  onPageChanged: (int index, _) {
                    model.setCurrentIndex(index);
                  },
                ),
                itemCount: model.totalImages,
                itemBuilder: (BuildContext context, int index, int realIndex) {
                  return model.image(index: realIndex) ?? placeholderImage;
                },
              ),
            ),
            Positioned(
              child: Padding(
                padding: EdgeInsets.only(
                  top: MediaQuery.of(context).padding.top + 24,
                  left: 24,
                  right: 24,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CupertinoButton(
                      padding: EdgeInsets.zero,
                      child: Icon(
                        Icons.close,
                        size: 24,
                        color: Colors.white,
                      ),
                      onPressed: model.tapCloseButton,
                    ),
                    Text(
                      '${model.currentIndex + 1}/${model.totalImages}',
                      style: Styles.caption01Light,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
