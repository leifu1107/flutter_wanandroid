import 'package:flutter/material.dart';
import 'package:flutter_wanandroid/net/NetUtil.dart';
import 'package:flutter_wanandroid/net/Api.dart';
import 'package:flutter_wanandroid/util/ToastUtil.dart';
import 'package:flutter_wanandroid/model/home/home_banner_item_model.dart';
import 'package:flutter_wanandroid/model/home/home_banner_model.dart';
import 'view/BannerViewPage.dart';
import 'view/HomeBanner.dart';
import 'view/SwiperBanner.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin {
  String data = "home";
  HomeBannerModel homeBannerModel;

  @override
  void initState() {
    super.initState();
    _loadBannerData();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
      children: <Widget>[
        HomeBanner(homeBannerModel, null),
        SwiperBanner(homeBannerModel),
      ],
    ));
  }

  void _loadBannerData() {
    NetUtil.getInstance().get(Api.HOME_BANNER, (data) {
//      ToastUtil.show(data.toString());
//      this.data = data.toString();
      homeBannerModel = HomeBannerModel.fromJson(data);
      this.data = homeBannerModel.data.elementAt(0).desc;

      setState(() {});
    });
  }

  @override
  bool get wantKeepAlive => true;
}
