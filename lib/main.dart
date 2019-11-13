import 'package:flutter/material.dart';
import 'package:flutter_wanandroid/ui/home/page/home_page.dart';
import 'package:flutter_wanandroid/ui/my/page/my_page.dart';
import 'package:flutter_wanandroid/ui/tag/page/tag_page.dart';
import 'ui/project/page/project_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: AppPage(),
    );
  }
}

class AppPage extends StatefulWidget {
  @override
  State<AppPage> createState() {
    return _MyHomePageState();
  }
}

class _MyHomePageState extends State<AppPage> with TickerProviderStateMixin {
  List<BottomNavigationBarItem> _bottomTabs = [];
  List tabData = [
    {
      'text': Text(
        "主页",
      ),
      'icon': Icon(Icons.home)
    },
    {'text': Text("项目"), 'icon': Icon(Icons.local_parking)},
    {'text': Text("体系"), 'icon': Icon(Icons.title)},
    {'text': Text("我的"), 'icon': Icon(Icons.airplanemode_active)}
  ];

  PageController _pageController;
  int _page = 0;

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < tabData.length; i++) {
      _bottomTabs.add(BottomNavigationBarItem(
        title: tabData[i]['text'],
        icon: tabData[i]['icon'],
      ));
    }
    _pageController = PageController(initialPage: this._page);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("测试DEMO"),
        ),
        body: PageView(
          controller: _pageController,
          children: <Widget>[
            HomePage(),
            ProjectPage(),
            TagPage(),
            MyPage(),
          ],
          onPageChanged: _onPageChanged,
          physics: NeverScrollableScrollPhysics(),
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: _bottomTabs,
          currentIndex: _page,
          selectedLabelStyle: TextStyle(fontSize: 14),
          type: BottomNavigationBarType.fixed,
          onTap: _onTap,
          backgroundColor: Colors.white,
          fixedColor: Colors.lightGreen,
        ),
      ),
    );
  }

  _onTap(int page) {
    _pageController.animateToPage(page,
        duration: Duration(milliseconds: 300), curve: Curves.ease);
  }

  void _onPageChanged(int page) {
    setState(() {
      this._page = page;
    });
  }
}
