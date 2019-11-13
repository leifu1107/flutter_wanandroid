import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_wanandroid/res/import_common.dart';

class ItemProjectWidget extends StatelessWidget {
  const ItemProjectWidget(
      {this.title, this.desc, this.time, this.imageUrl, Key key})
      : super(key: key);
  final String title;
  final String desc;
  final String time;
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: InkWell(
        child: Container(
          height: 160,
          padding: EdgeInsets.all(20),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(
                      title ?? "",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyles.listTitle,
                    ),
                    Gaps.vGap10,
                    Expanded(
                      flex: 1,
                      child: new Text(
                        desc ?? "",
                        maxLines: 3,
                        softWrap: true,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyles.listContent,
                      ),
                    ),
                    Gaps.vGap5,
                    Row(
                      children: <Widget>[
                        Icon(
                          Icons.favorite,
                        ),
                        Text(
                          time ?? "",
                          style: TextStyles.listExtra,
                        )
                      ],
                    )
                  ],
                ),
              ),
              CachedNetworkImage(
                imageUrl: imageUrl ?? "",
                width: 72,
                height: 128,
                fit: BoxFit.fill,
                errorWidget: (BuildContext context, String url, Object error) {
                  return new Icon(Icons.error);
                },
              )
            ],
          ),
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                  bottom: BorderSide(width: 0.5, color: Colours.divider))),
        ),
      ),
    );
  }
}
