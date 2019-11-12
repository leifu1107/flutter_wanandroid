import 'package:flutter/material.dart';
import 'package:flutter_wanandroid/util/swiper.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_wanandroid/model/home/home_banner_model.dart';

class SwiperBanner extends StatelessWidget {
  final HomeBannerModel homeBannerModel;

  SwiperBanner(this.homeBannerModel, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
        aspectRatio: 16 / 9,
        child: Swiper(
          circular: true,
          interval: Duration(seconds: 3),
          indicator: NumberSwiperIndicator(),
          indicatorAlignment: AlignmentDirectional.topEnd,
          children: homeBannerModel.data.map((data) {
            return InkWell(
              child: CachedNetworkImage(
                imageUrl: data.imagePath,
                fit: BoxFit.cover,
              ),
            );
          }).toList(),
        ));
  }
}

class NumberSwiperIndicator extends SwiperIndicator {
  @override
  Widget build(BuildContext context, int index, int itemCount) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: Colors.black45, borderRadius: BorderRadius.circular(20)),
      child: Text(
        "${++index}/$itemCount",
        style: TextStyle(color: Colors.white70, fontSize: 11),
      ),
    );
  }
}
