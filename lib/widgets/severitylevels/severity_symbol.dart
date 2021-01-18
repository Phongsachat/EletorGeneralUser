import 'package:flutter/cupertino.dart';

class SeveritySymbol {
  final Color color;
  final double width;
  final double height;

  SeveritySymbol({@required this.color, this.height, this.width});

  Widget circleSymbol() {
    return Container(
        width: width ?? 20,
        height: height ?? 20,
        decoration: BoxDecoration(color: color, shape: BoxShape.circle));
  }
}
