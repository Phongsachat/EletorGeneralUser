import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

class ContentStyle extends StatelessWidget {
  final String content;
  final int maxLines;

  const ContentStyle({Key key,@required this.content,this.maxLines}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      content,
      style: TextStyle(
          color: Colors.black,
          fontFamily: primaryFontFamily,
          fontSize: 12,
          wordSpacing: 1.5),
      overflow: TextOverflow.ellipsis,
      maxLines: maxLines ?? null,
    );
  }
}
