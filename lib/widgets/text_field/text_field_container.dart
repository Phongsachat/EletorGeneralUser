
import 'package:Eletor/widgets/constants.dart';
import 'package:flutter/material.dart';

class TextFieldContainer extends StatelessWidget {
  final Widget child;
  final double width, height, radius,verticalSize;
  final Color color;
  const TextFieldContainer({
    Key key,
    this.child, this.width, this.height, this.radius, this.color,this.verticalSize
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: verticalSize ?? 0),
      width: width ?? size.width * 0.8,
      height: height ?? null,
      decoration: BoxDecoration(
        color: color ?? bgTxtField,
        borderRadius: BorderRadius.circular(radius ?? 29),
      ),
      child: child,
    );
  }
}
