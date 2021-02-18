import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:kickdown_app/styles.dart';

class PostingPhotosSliderView extends StatelessWidget {
  static const imageURLs = [
    'https://www.kickdown.com/rails/active_storage/blobs/eyJfcmFpbHMiOnsibWVzc2FnZSI6IkJBaHBBZ1l1IiwiZXhwIjpudWxsLCJwdXIiOiJibG9iX2lkIn19--4857d17bf70a2b3f4b561e6aa7c568c9b95232bb/WhatsApp%20Image%202021-02-08%20at%2020.03.53.jpg',
    'https://www.kickdown.com/rails/active_storage/blobs/eyJfcmFpbHMiOnsibWVzc2FnZSI6IkJBaHBBZ2N1IiwiZXhwIjpudWxsLCJwdXIiOiJibG9iX2lkIn19--5595f05b48bc6af087133adb03a1185cc768dd28/WhatsApp%20Image%202021-02-08%20at%2020.03.55.jpg',
    'https://www.kickdown.com/rails/active_storage/blobs/eyJfcmFpbHMiOnsibWVzc2FnZSI6IkJBaHBBaDR1IiwiZXhwIjpudWxsLCJwdXIiOiJibG9iX2lkIn19--08df8f9cfc8136b186bbcfc905233dd83e4c3e4c/SAM_7867.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: Colors.black,
      child: Stack(
        children: [
          Center(
            child: CarouselSlider(
              options: CarouselOptions(
                height: MediaQuery.of(context).size.height * 0.38,
                scrollDirection: Axis.horizontal,
                enableInfiniteScroll: false,
                initialPage: 0,
                viewportFraction: 1,
              ),
              items: imageURLs
                  .map(
                    (imageURL) => CachedNetworkImage(
                      width: double.infinity,
                      placeholder: (context, url) => Text('Loading'),
                      imageUrl: imageURL,
                    ),
                  )
                  .toList(),
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
                    onPressed: () => print('tap close'),
                  ),
                  Text(
                    '1/119',
                    style: Styles.caption01Light,
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
