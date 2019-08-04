import 'package:flutter/material.dart';
import 'package:banner_view/banner_view.dart';

class BannerViewPage extends StatefulWidget {
  @override
  _BannerViewPageState createState() => new _BannerViewPageState();
}

class _BannerViewPageState extends State<BannerViewPage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Container(
        child: new Column(
          children: <Widget>[
            new Container(
              alignment: Alignment.center,
              height: 200.0,
              child: this._bannerView(),
              padding: EdgeInsets.only(bottom: 10.0),
            )
          ],
        ),
      ),
    );
  }

  /**
   * 第二种方式
   */
  BannerView _bannerView() {
    List<String> bannerList = [
      'https://raw.githubusercontent.com/yangxiaoweihn/Assets/master/cars/car_0.jpg',
      'https://raw.githubusercontent.com/yangxiaoweihn/Assets/master/cartoons/ct_0.jpg',
      'https://raw.githubusercontent.com/yangxiaoweihn/Assets/master/cars/car_0.jpg',
    ];

    return new BannerView(
      bannerList.map((String item) {
        return new GestureDetector(
            onTap: () {},
            child: new Image.network(
              item,
              fit: BoxFit.cover,
            ));
      }).toList(),
      animationDuration: const Duration(milliseconds: 2000),
      indicatorMargin: 10.0,
      indicatorNormal: new Container(
        width: 5.0,
        height: 5.0,
        decoration: new BoxDecoration(
          color: Colors.green,
          shape: BoxShape.rectangle,
        ),
      ),
      indicatorSelected: new Container(
        width: 15.0,
        height: 5.0,
        decoration: new BoxDecoration(
          color: Colors.deepOrange,
          shape: BoxShape.rectangle,
          borderRadius: new BorderRadius.all(
            new Radius.circular(5.0),
          ),
        ),
      ),
      indicatorBuilder: (context, indicator) {
        return new Opacity(
          opacity: 0.5,
          child: new Container(
            padding: new EdgeInsets.symmetric(
              horizontal: 20.0,
            ),
            height: 44.0,
            width: double.infinity,
            color: Colors.grey[300],
            child: indicator,
          ),
        );
      },
    );
  }
}
