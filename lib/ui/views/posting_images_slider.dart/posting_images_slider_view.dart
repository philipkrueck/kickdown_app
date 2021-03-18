import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kickdown_app/styles.dart';
import 'package:kickdown_app/ui/shared/posting_header/posting_header.dart';
import 'package:kickdown_app/ui/views/posting_images_slider.dart/posting_images_slider_viewmodel.dart';
import 'package:kickdown_app/utils/global_image_cache_manager.dart';
import 'package:stacked/stacked.dart';
import 'package:photo_view/photo_view.dart';

class PostingImagesSliderView extends StatelessWidget {
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
            Container(
              child: Center(
                child: ListView.builder(
                  controller: model.pageController,
                  physics: const PageScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemCount: model.imageUrls.length,
                  itemBuilder: (BuildContext context, int index) => Row(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        child: CachedNetworkImage(
                          cacheManager: GlobalImageCacheManager(),
                          fit: BoxFit.cover,
                          imageUrl: model.imageUrls[index],
                          imageBuilder: (context, image) => PhotoView(
                            imageProvider: image,
                            // customSize: Size(screenWidth, 100),
                            initialScale: PhotoViewComputedScale.contained,
                            maxScale: PhotoViewComputedScale.contained * 2.5,
                            minScale: PhotoViewComputedScale.contained,
                          ),
                          placeholder: (BuildContext context, String url) =>
                              placeholderImage,
                        ),
                      ),
                    ],
                  ),
                ),
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
                      child: const Icon(
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
