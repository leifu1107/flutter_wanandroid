import 'package:flutter_wanandroid/res/import_common.dart';

class ItemHomeArticle extends StatelessWidget {
  const ItemHomeArticle(
      {this.title, this.leftSubTitle, this.rightSubTitle, Key key})
      : super(key: key);
  final String title;
  final String leftSubTitle;
  final String rightSubTitle;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Ink(
        child: InkWell(
          child: Container(
            height: 70,
            color: Colors.white,
            padding: EdgeInsets.only(left: 20, right: 20,top: 10,bottom: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(title ?? "",
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
                    Text(leftSubTitle ?? "",
                        style: TextStyle(
                          color: Colors.black26,
                          fontSize: 14,
                        )),
                    Expanded(
                      child: Container(),
                      flex: 1,
                    ),
                    Text(rightSubTitle ?? "",
                        style: TextStyle(
                          color: Colors.black26,
                          fontSize: 14,
                        ))
                  ],
                ),
                Gaps.vGap5,
                Divider(
                  height: 1,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
