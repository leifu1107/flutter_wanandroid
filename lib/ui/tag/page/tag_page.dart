import 'package:flutter_wanandroid/model/tag/tag_list_model.dart';
import 'package:flutter_wanandroid/ui/project/widget/item_project_widget.dart';
import 'package:flutter_wanandroid/res/import_common.dart';
import 'package:flutter_wanandroid/ui/tag/widget/tree_item.dart';

class TagPage extends StatefulWidget {
  @override
  _TagPageState createState() {
    return _TagPageState();
  }
}

class _TagPageState extends State<TagPage> with AutomaticKeepAliveClientMixin {
  TagListModel tagListModel;

  @override
  void initState() {
    super.initState();
    _loadHomeArticleData();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    if (ObjectUtil.isEmpty(tagListModel)) {
      return Center(
        child: Text("暂无数据"),
      );
    }
    return Material(
        child: Container(
      child: ListView.builder(
          padding: EdgeInsets.all(10),
          itemCount: tagListModel.data.length,
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              onTap: () {},
              child: TreeItem(tagListModel.data[index]),
            );
          }),
    ));
  }

//加载首页文章列表
  void _loadHomeArticleData() {
    NetUtil.get(Api.TREE, (map) {
      tagListModel = TagListModel.fromJson(map);
      setState(() {});
    });
  }

  @override
  bool get wantKeepAlive => true;
}
