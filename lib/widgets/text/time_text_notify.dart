import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

class TimeNotifyText extends StatelessWidget {
  final String text;
  final double size;
  final Color color;

  const TimeNotifyText({Key key,@required this.text, this.size, this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AutoSizeText(
      text,
      maxLines: 1,
      style: TextStyle(
          fontSize: size ?? 6,
          color: color ?? Colors.grey,
          fontFamily: primaryFontFamily),
    );
  }
}
