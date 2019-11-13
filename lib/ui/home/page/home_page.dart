import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_wanandroid/res/import_common.dart';
import 'package:flutter_wanandroid/ui/home/widget/item_home_article_widget.dart';
import 'package:flutter_wanandroid/util/head_item_widget.dart';
import 'package:flutter_wanandroid/model/home/home_banner_model.dart';
import '../widget/swiper_banner_widget.dart';
import 'package:flutter_wanandroid/model/home/home_article_list_model.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin {
  HomeBannerModel homeBannerModel;

  HomeArticleListModel homeArticleListModel;

  @override
  void initState() {
    super.initState();
    _loadBannerData();
    _loadHomeArticleData();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    if (homeBannerModel == null || homeArticleListModel == null) {
      return Text("暂无数据");
    }

    return Container(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(
            child: CustomScrollView(
          slivers: <Widget>[
            //其它控件需要外层添加SliverToBoxAdapter
            SliverToBoxAdapter(child: SwiperBanner(homeBannerModel)),
            SliverToBoxAdapter(
                child: HeaderItem(
              title: "推荐项目",
              extra: "更多",
              onTap: () {
                ToastUtil.show("点击了");
              },
            )),
            SliverFixedExtentList(
              delegate: SliverChildBuilderDelegate(
                  (context, index) => GestureDetector(
                        onTap: () {
                          // 使用 Navigator 跳转页面CupertinoPageRoute ios风格可以滑动返回;
                          // MaterialPageRoute Android风格
                          Navigator.push(context,
                              CupertinoPageRoute(builder: (_) {
                            return WebViewPage(
                              url: homeArticleListModel.data.datas[index].link,
                              title:
                                  homeArticleListModel.data.datas[index].title,
                            );
                          }));
                        },
                        child: ItemHomeArticle(
                          title: homeArticleListModel.data.datas[index].title,
                          leftSubTitle:
                              "作者:${homeArticleListModel.data.datas[index].author}",
                          rightSubTitle:
                              "时间:${homeArticleListModel.data.datas[index].niceDate}",
                        ),
                      ),
                  childCount: homeArticleListModel.data.size),
              itemExtent: 70,
            )
          ],
        ))
      ],
    ));
  }

  //加载首页banner
  void _loadBannerData() {
    NetUtil.get(Api.HOME_BANNER, (map) {
      homeBannerModel = HomeBannerModel.fromJson(map);
      setState(() {});
    });
  }

//加载首页文章列表
  void _loadHomeArticleData() {
    NetUtil.get(Api.HOME_ARTICLE_LIST, (map) {
      homeArticleListModel = HomeArticleListModel.fromJson(map);
      setState(() {});
    });
  }

  @override
  bool get wantKeepAlive => true;
}
