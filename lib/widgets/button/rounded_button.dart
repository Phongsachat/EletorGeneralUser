import 'package:Eletor/widgets/constants.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:Eletor/extensions/ContainerExtension.dart';

class RoundedButton extends StatelessWidget {
  final String text;
  final Function onTap;
  final Color color, textColor;
  final EdgeInsetsGeometry padding;
  final int maxLines;
  final double width, fontSize, height, radius;

  const RoundedButton({
    Key key,
    this.text,
    this.onTap,
    this.color = btnLoginButton,
    this.textColor = Colors.white,
    this.padding,
    this.maxLines,
    this.fontSize,
    this.width,
    this.height,
    this.radius,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      width: width ?? size.width * 0.8,
      height: height ?? null,
      decoration: BoxDecoration().shadow(),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(radius ?? 29),
        child: FlatButton(
          padding:
              padding ?? EdgeInsets.symmetric(vertical: 20, horizontal: 40),
          color: color,
          onPressed: onTap,
          child: AutoSizeText(
            text,
            maxLines: maxLines ?? 1,
            style: TextStyle(
              fontFamily: primaryFontFamily,
              fontSize: fontSize ?? 14.0,
              color: textColor ?? null,
            ),
          ),
        ),
      ),
    );
  }
}
