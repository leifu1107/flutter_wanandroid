import 'package:flutter_wanandroid/res/import_common.dart';

class TabBarPage extends StatefulWidget {
  @override
  _TabBarPageState createState() {
    return _TabBarPageState();
  }
}

// 继承SingleTickerProviderStateMixin，提供单个Ticker（每个动画帧调用它的回调一次）
class _TabBarPageState extends State<TabBarPage>
    with SingleTickerProviderStateMixin {
  TabController controller;
  var tabs = <Tab>[];

  @override
  void initState() {
    super.initState();
    tabs = <Tab>[
      Tab(
        text: "Tab1",
      ),
      Tab(
        text: "Tab2",
      ),
      Tab(
        text: "Tab3",
      ),
      Tab(
        text: "Tab4",
      ),
      Tab(
        text: "Tab5",
      ),
      Tab(
        text: "Tab6",
      ),
      Tab(
        text: "Tab7",
      ),
      Tab(
        text: "Tab8",
      ),
      Tab(
        text: "Tab9",
      ),
    ];

//initialIndex初始选中第几个
    controller =
        TabController(initialIndex: 3, length: tabs.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("TabBarDemo"),
          bottom: TabBar(
            controller: controller,
            //可以和TabBarView使用同一个TabController
            tabs: tabs,
            isScrollable: true,
            indicatorColor: Colors.white,
            indicatorWeight: 2,
            labelStyle: TextStyle(
              fontSize: 18.0,
            ),
            unselectedLabelColor: Colors.white,
            unselectedLabelStyle: TextStyle(
              fontSize: 12.0,
            ),
          ),
        ),
        body: DefaultTabController(
          length: tabs.length,
          child: TabBarView(
              controller: controller,
              children: tabs
                  .map((Tab tab) => Container(
                        child: Center(
                          child: Text(tab.text),
                        ),
                      ))
                  .toList()),
        ));
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }
}
