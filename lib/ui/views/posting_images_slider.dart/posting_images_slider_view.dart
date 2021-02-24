import 'package:flutter/cupertino.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:kickdown_app/styles.dart';
import 'package:kickdown_app/ui/shared/posting_header/posting_header.dart';
import 'package:kickdown_app/ui/views/posting_images_slider.dart/posting_images_slider_viewmodel.dart';
import 'package:stacked/stacked.dart';
import 'package:vector_math/vector_math_64.dart' hide Colors;

class PostingImagesSliderView extends StatefulWidget {
  static const imageURLs = [
    'https://www.kickdown.com/rails/active_storage/blobs/eyJfcmFpbHMiOnsibWVzc2FnZSI6IkJBaHBBZ1l1IiwiZXhwIjpudWxsLCJwdXIiOiJibG9iX2lkIn19--4857d17bf70a2b3f4b561e6aa7c568c9b95232bb/WhatsApp%20Image%202021-02-08%20at%2020.03.53.jpg',
    'https://www.kickdown.com/rails/active_storage/blobs/eyJfcmFpbHMiOnsibWVzc2FnZSI6IkJBaHBBZ2N1IiwiZXhwIjpudWxsLCJwdXIiOiJibG9iX2lkIn19--5595f05b48bc6af087133adb03a1185cc768dd28/WhatsApp%20Image%202021-02-08%20at%2020.03.55.jpg',
    'https://www.kickdown.com/rails/active_storage/blobs/eyJfcmFpbHMiOnsibWVzc2FnZSI6IkJBaHBBaDR1IiwiZXhwIjpudWxsLCJwdXIiOiJibG9iX2lkIn19--08df8f9cfc8136b186bbcfc905233dd83e4c3e4c/SAM_7867.jpg',
  ];

  final PostingImagesSliderViewmodel postingImagesSliderViewmodel;

  const PostingImagesSliderView({@required this.postingImagesSliderViewmodel});

  @override
  _PostingImagesSliderViewState createState() =>
      _PostingImagesSliderViewState();
}

class _PostingImagesSliderViewState extends State<PostingImagesSliderView>
    with SingleTickerProviderStateMixin {
  Animation _animation;
  AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300));
    _animation = Tween(begin: 1.0, end: 3.0).animate(
        CurvedAnimation(parent: _animationController, curve: Curves.easeInOut))
      ..addListener(
        () {
          setState(() {});
        },
      );
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<PostingImagesSliderViewmodel>.reactive(
      initialiseSpecialViewModelsOnce: true,
      viewModelBuilder: () => widget.postingImagesSliderViewmodel,
      builder: (context, model, child) => CupertinoPageScaffold(
        backgroundColor: Colors.black,
        child: Stack(
          children: [
            Container(
              child: Center(
                child: CarouselSlider.builder(
                  options: CarouselOptions(
                    height: double.infinity,
                    scrollDirection: Axis.horizontal,
                    enableInfiniteScroll: false,
                    initialPage: model.currentIndex,
                    viewportFraction: 1,
                    onPageChanged: (int index, _) {
                      model.setCurrentIndex(index);
                    },
                  ),
                  itemCount: model.totalImages,
                  itemBuilder:
                      (BuildContext context, int index, int realIndex) {
                    if (model.image(index: realIndex) != null) {
                      return InteractiveViewer(
                        boundaryMargin: EdgeInsets.all(double.infinity),
                        panEnabled: false,
                        minScale: 1.0,
                        maxScale: 3.0,
                        child: GestureDetector(
                          onDoubleTap: () {
                            if (_animationController.isCompleted) {
                              _animationController.reverse();
                            } else {
                              _animationController.forward();
                            }
                          },
                          child: Transform(
                            alignment: FractionalOffset.center,
                            transform: Matrix4.diagonal3(Vector3(
                              _animation.value,
                              _animation.value,
                              _animation.value,
                            )),
                            child: Image(
                              image: model.image(index: realIndex).image,
                              fit: BoxFit.fitWidth,
                            ),
                          ),
                        ),
                      );
                    }

                    return AspectRatio(
                      aspectRatio: 16 / 9,
                      child: Image(
                        image: placeholderImage.image,
                        fit: BoxFit.fitWidth,
                      ),
                    );
                  },
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
