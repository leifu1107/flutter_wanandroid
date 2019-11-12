import 'package:flutter/material.dart';
import 'package:flutter_wanandroid/ui/main/page/webview_page.dart';
import 'package:flutter_wanandroid/ui/project/widget/item_project_widget.dart';
import 'package:flutter_wanandroid/res/import_common.dart';
import 'package:flutter_wanandroid/model/home/home_article_list_model.dart';

class ProjectPage extends StatefulWidget {
  @override
  _ProjectPageState createState() {
    return _ProjectPageState();
  }
}

class _ProjectPageState extends State<ProjectPage>
    with AutomaticKeepAliveClientMixin {
  HomeArticleListModel homeArticleListModel;

  @override
  void initState() {
    super.initState();
    _loadHomeArticleData();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    if (ObjectUtil.isEmpty(homeArticleListModel)) {
      return Center(
        child: Text("暂无数据"),
      );
    }
    return Container(
      child: ListView.builder(
          padding: EdgeInsets.all(10),
          itemExtent: 160,
          itemCount: homeArticleListModel.data.size,
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              onTap: () {
                // 使用 Navigator 跳转页面
                Navigator.push(context, MaterialPageRoute(builder: (_) {
                  return WebViewPage(
                    url: homeArticleListModel.data.datas[index].link,
                    title: homeArticleListModel.data.datas[index].title,
                  );
                }));
              },
              child: ItemProjectWidget(
                title: homeArticleListModel.data.datas[index].title,
                desc: homeArticleListModel.data.datas[index].desc,
                time: homeArticleListModel.data.datas[index].niceDate,
                imageUrl: homeArticleListModel.data.datas[index].envelopePic,
              ),
            );
          }),
    );
  }

//加载首页文章列表
  void _loadHomeArticleData() {
    NetUtil.get(Api.PROJECT_LIST, (map) {
      homeArticleListModel = HomeArticleListModel.fromJson(map);
      setState(() {});
    });
  }

  @override
  bool get wantKeepAlive => true;
}
