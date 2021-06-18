import 'package:cats_app/helpers/constants.dart';
import 'package:flutter/material.dart';
import 'catTag.dart';

class CatCard extends StatelessWidget {
  final String catId;
  final List<String> catTags;

  CatCard({@required this.catId, @required this.catTags});

  List<Widget> getTagWidgets() {
    List<Widget> _list = [];
    int tagsCount = catTags.length;
    for (int i = 0; i < (tagsCount > 3 ? 3 : tagsCount); i++) {
      _list.add(CatTag(
        tag: catTags[i],
      ));
    }
    if (tagsCount > 3) {
      _list.add(CatTag(
        tag: '...',
      ));
    }

    return _list;
  }

  @override
  Widget build(BuildContext context) {
    //List<CatTag> tagsWidgets = catTags.map((e) => CatTag(tag: e));
    return Container(
      padding: EdgeInsets.only(left: 15.0, right: 15.0, top: 5.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            catId,
            style: kIdStyle,
          ),
          Row(
            children: getTagWidgets(),
          ),
        ],
      ),
    );
  }
}
