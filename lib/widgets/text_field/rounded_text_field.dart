import 'package:Eletor/widgets/constants.dart';
import 'package:Eletor/widgets/text_field/text_field_container.dart';
import 'package:flutter/material.dart';

class RoundedTextField extends StatelessWidget {
  final ValueChanged<String> onChanged;
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;
  final InputBorder border;
  final double width, height;
  final IconData icon;
  final Color iconColor, bgColor;
  final double radius;

  const RoundedTextField({
    Key key,
    this.onChanged,
    this.hintText,
    this.obscureText,
    this.border,
    this.width,
    this.height,
    this.iconColor,
    this.icon,
    this.bgColor,
    this.radius,
    this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      color: bgColor ?? null,
      radius: radius ?? null,
      height: height ?? null,
      width: width ?? null,
      child: TextField(
        obscureText: obscureText ?? false,
        onChanged: onChanged,
        controller: controller,
        cursorColor: cursorTxtFieldColor,
        style: TextStyle(
          fontFamily: primaryFontFamily,
          fontWeight: FontWeight.w500,
        ),
        decoration: InputDecoration(
          hintStyle: TextStyle(
              fontFamily: primaryFontFamily, color: hintTxtFieldColor ?? null),
          hintText: hintText ?? null,
          icon: Icon(
            icon,
            color: iconColor ?? iconTxtFieldColor,
          ),
          border: border ?? InputBorder.none,
        ),
      ),
    );
  }
}
