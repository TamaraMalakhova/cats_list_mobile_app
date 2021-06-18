import 'package:flutter/material.dart';
import '../helpers/constants.dart';

class CatTag extends StatelessWidget {
  final String tag;
  CatTag({@required this.tag});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 1.0, horizontal: 5.0),
      margin: EdgeInsets.only(left: 10.0),
      decoration: BoxDecoration(
        color: kTagContainerColor,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Text(tag),
    );
  }
}
