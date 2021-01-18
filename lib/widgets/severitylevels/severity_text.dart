import 'dart:ui';

import 'package:Eletor/widgets/constants.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';

class SeverityText {
  final Color color;
  final String text;
  final double size;

  SeverityText({@required this.color,@required this.text, this.size});

  Widget severityText() {
    return Container(
      child: AutoSizeText(
        text,
        style: TextStyle(color: color, fontFamily: primaryFontFamily, fontSize: size ?? 16,fontWeight: FontWeight.bold),
      ),
    );
  }
}
