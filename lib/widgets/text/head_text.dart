import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

class HeaderText extends StatelessWidget {

  final String title;
  final double size;
  final Color color;

  const HeaderText({Key key,@required this.title, this.size, this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AutoSizeText(
      title,
      maxLines: 2,
      style: TextStyle(
          color: color ?? Colors.black,
          fontWeight: FontWeight.w600,
          fontSize: size ?? 15,
          fontFamily: primaryFontFamily),
    );
  }
}
