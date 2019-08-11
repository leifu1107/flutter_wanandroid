import 'package:flutter/material.dart';
import 'package:flutter_wanandroid/res/import_common.dart';

class HeaderItem extends StatelessWidget {
  const HeaderItem(
      {this.margin,
      this.titleColor,
      this.leftIcon,
      this.title,
      this.extra,
      this.rightIcon,
      this.onTap,
      Key key})
      : super(key: key);

  final EdgeInsetsGeometry margin;
  final Color titleColor;
  final IconData leftIcon;
  final String title;
  final String extra;
  final IconData rightIcon;
  final GestureTapCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56,
      margin: margin ?? EdgeInsets.only(top: 0.0),
      child: ListTile(
        onTap: onTap,
        title: Row(
          children: <Widget>[
            Icon(
              leftIcon ?? Icons.whatshot,
              color: titleColor ?? Colors.blueAccent,
            ),
            Gaps.hGap10,
            Expanded(
                child: Text(title ?? "",
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        color: titleColor ?? Colors.blueAccent, fontSize: 14))),
          ],
        ),
        trailing: new Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            new Text(
              extra ?? "",
              style: TextStyle(color: Colors.grey, fontSize: 14),
            ),
            new Icon(
              rightIcon ?? Icons.keyboard_arrow_right,
              color: Colors.grey,
            ),
          ],
        ),
      ),
    );
  }
}
