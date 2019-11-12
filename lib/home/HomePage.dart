
import 'package:flutter/material.dart';
import 'package:flutter_wanandroid/res/import_common.dart';
import 'package:flutter_wanandroid/util/head_item.dart';
import 'package:flutter_wanandroid/model/home/home_banner_model.dart';
import 'view/swiperbanner.dart';
import 'package:flutter_wanandroid/model/home/home_article_list_model.dart';
import 'package:flutter_wanandroid/home/view/item_home_article.dart';

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
            )),
            SliverFixedExtentList(
              delegate: SliverChildBuilderDelegate(
                  (context, index) => ItemHomeArticle(
                        title: homeArticleListModel.data.datas[index].title,
                        leftSubTitle:
                            "作者:${homeArticleListModel.data.datas[index].author}",
                        rightSubTitle:
                            "时间:${homeArticleListModel.data.datas[index].niceDate}",
                      ),
                  childCount: homeArticleListModel.data.size),
              itemExtent: 70,
            )
          ],
        ))
      ],
    ));
  }

  Widget _buildListItem(BuildContext context, int index) {
    return Container(
      height: 70,
      padding: EdgeInsets.only(left: 20, right: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(homeArticleListModel.data.datas[index].title,
              softWrap: false,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.w700,
              )),
          Gaps.vGap5,
          Row(
            children: <Widget>[
              Text("作者:${homeArticleListModel.data.datas[index].author}",
                  style: TextStyle(
                    color: Colors.black26,
                    fontSize: 14,
                  )),
              Expanded(
                child: Container(),
                flex: 1,
              ),
              Text("时间:${homeArticleListModel.data.datas[index].niceDate}",
                  style: TextStyle(
                    color: Colors.black26,
                    fontSize: 14,
                  ))
            ],
          ),
          Gaps.vGap10,
          Divider(
            height: 1,
          )
        ],
      ),
    );
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
