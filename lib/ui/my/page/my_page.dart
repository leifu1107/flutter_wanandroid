import 'package:flutter/material.dart';
import 'package:flutter_wanandroid/res/styles.dart';
import 'package:flutter_wanandroid/util/toast_util.dart';

class MyPage extends StatelessWidget {
  MyPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              margin: EdgeInsets.all(20),
              alignment: Alignment.center,
              child: CircleAvatar(
                backgroundImage: NetworkImage('http://n.sinaimg'
                    '.cn/sports/2_img/upload/cf0d0fdd/107/w1024h683/20181128/pKtl-hphsupx4744393.jpg'),
                radius: 50.0,
              ),
            ),
            ListTile(
              leading: Icon(Icons.info),
              title: Text(
                "关于",
              ),
              trailing: Icon(Icons.keyboard_arrow_right),
              onTap: () {
                ToastUtil.show("点击了");
              },
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text(
                "设置",
              ),
              trailing: Icon(Icons.keyboard_arrow_right),
              onTap: () {
                ToastUtil.show("点击了");
              },
            ),
            ListTile(
              leading: Icon(Icons.view_quilt),
              title: Text(
                "退出",
              ),
              trailing: Icon(Icons.keyboard_arrow_right),
              onTap: () {
                _showLoginOutDialog(context);
              },
            )
          ],
        ),
      ),
    );
  }

  void _showLoginOutDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (ctx) {
          return AlertDialog(
            content: Text(
              "确定退出吗？",
            ),
            actions: <Widget>[
              FlatButton(
                child: Text(
                  "取消",
                  style: TextStyles.listExtra2,
                ),
                onPressed: () {
                  Navigator.pop(ctx);
                },
              ),
              FlatButton(
                child: Text(
                  "确定",
                  style: TextStyles.listExtra,
                ),
                onPressed: () {},
              ),
            ],
          );
        });
  }
}
