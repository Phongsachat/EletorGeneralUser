import 'package:Eletor/extensions/ContainerExtension.dart';
import 'package:Eletor/widgets/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RoundedIconButton extends StatelessWidget {
  final String text;
  final Function onTap;
  final Color color, textColor;
  final EdgeInsetsGeometry padding;
  final double width, height;
  final Widget icons;

  const RoundedIconButton({
    Key key,
    this.text,
    this.onTap,
    this.color = btnGoogleSignIn,
    this.textColor = Colors.black,
    this.padding,
    this.icons,
    this.width,
    this.height,
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
        borderRadius: BorderRadius.circular(29),
        child: FlatButton.icon(
            onPressed: onTap,
            icon: icons,
            color: color,
            padding: padding ?? EdgeInsets.symmetric(vertical: 20, horizontal: 40),
            label: Text(
              text,
              style: TextStyle(fontFamily:primaryFontFamily,fontSize: 16,color: textColor ?? null,fontWeight: FontWeight.bold),
            )),
      ),
    );
  }
}
