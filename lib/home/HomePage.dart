import 'package:flutter/material.dart';
import 'package:flutter_wanandroid/res/import_common.dart';
import 'package:flutter_wanandroid/util/head_item.dart';
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
    super.build(context);
    return Container(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(
            child: ListView(
          children: <Widget>[
            SwiperBanner(homeBannerModel),
            HeaderItem(
              title: "推荐项目",
              extra: "更多",
            ),
            Text(
              "string",
              style: TextStyle(color: Colors.deepOrange, fontSize: 100),
            ),
          ],
        ))
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
