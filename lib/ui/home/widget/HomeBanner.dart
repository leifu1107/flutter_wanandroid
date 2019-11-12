import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_wanandroid/model/home/home_banner_model.dart';
import 'package:flutter_wanandroid/util/log_util.dart';
/*阿里巴巴的做法*/
class HomeBanner extends StatefulWidget {
  final HomeBannerModel homeBannerModel;
  final OnTapBannerItem onTap;

  HomeBanner(this.homeBannerModel, this.onTap, {Key key}) : super(key: key);

  @override
  _HomeBannerState createState() {
    return _HomeBannerState();
  }
}

class _HomeBannerState extends State<HomeBanner> {
  int virtualIndex = 0;
  int realIndex = 1;
  PageController controller;
  Timer timer;

  @override
  void initState() {
    super.initState();
    controller = PageController(initialPage: realIndex);
    timer = Timer.periodic(Duration(seconds: 3), (timer) {
      controller.animateToPage(realIndex + 1,
          duration: Duration(milliseconds: 300), curve: Curves.linear);
    });
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
    timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topCenter,
      height: 200,
      child: Stack(
        alignment: Alignment.topCenter,
        children: <Widget>[
          PageView(
            controller: controller,
            onPageChanged: _onPageChanged,
            children: _buildItems(widget.homeBannerModel),
          ),
          Positioned(
            top: 170,
            child: _buildIndicator(),
          )
          // 下面的小点
        ],
      ),
    );
  }

  List<Widget> _buildItems(HomeBannerModel homeBannerModel) {
    List<Widget> items = [];
    if (widget.homeBannerModel.data.length > 0) {
      //给用户错觉视觉
      // 头部添加一个尾部Item，模拟循环
      items.add(_buildItem(
          widget.homeBannerModel.data[widget.homeBannerModel.data.length - 1]));
      homeBannerModel.data
          .map((data) => items.add(_buildItem(data)))
          .toList(growable: false);
      items.add(_buildItem(widget.homeBannerModel.data[0]));
    }

    return items;
  }

  Widget _buildItem(Data data) {
    return GestureDetector(
      onTap: () {
        if (widget.onTap != null) {
          widget.onTap(data);
        }
      },
      child: Stack(children: <Widget>[
        Image.network(
          data.imagePath,
          height: 200,
          fit: BoxFit.cover,
        ),
      ]),
    );
  }

  Widget _buildIndicator() {
    List<Widget> indicators = [];
    for (int i = 0; i < widget.homeBannerModel.data.length; i++) {
      indicators.add(Container(
        width: 6,
        height: 6,
        margin: EdgeInsets.symmetric(horizontal: 2, vertical: 10),
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: i == virtualIndex ? Colors.white : Colors.grey),
      ));
    }
    return Row(
      children: indicators,
      mainAxisAlignment: MainAxisAlignment.center,
    );
  }

  void _onPageChanged(int index) {
    int count = widget.homeBannerModel.data.length;
    LogUtil.e("index $index" + "count $count" + "realIndex $realIndex");
    realIndex = index;
    if (index == 0) {
      virtualIndex = count - 1;
      controller.jumpToPage(count);
    } else if (index == count + 1) {
      virtualIndex = 0;
      controller.jumpToPage(1);
    } else {
      virtualIndex = index - 1;
    }
    setState(() {});
  }
}

typedef void OnTapBannerItem(Data data);
