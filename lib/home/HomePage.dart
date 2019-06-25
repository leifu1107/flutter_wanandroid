import 'package:flutter/material.dart';
import 'package:flutter_wanandroid/net/NetUtil.dart';
import 'package:flutter_wanandroid/net/Api.dart';
import 'package:flutter_wanandroid/util/ToastUtil.dart';
import 'package:flutter_wanandroid/model/home/home_banner_item_model.dart';
import 'package:flutter_wanandroid/model/home/home_banner_model.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin {
  String data = "home";

  @override
  void initState() {
    super.initState();
    _loadBannerData();
  }

  @override
  Widget build(BuildContext context) {
    return Text("$data");
  }

  void _loadBannerData() {
    NetUtil.getInstance().get(Api.HOME_BANNER, (data) {
      ToastUtil.show(data.toString());
//      this.data = data.toString();
      var homeBannerModel = HomeBannerModel.fromJson(data);
      this.data = homeBannerModel.data.toString();

      setState(() {});
    });
  }

  @override
  bool get wantKeepAlive => true;
}
