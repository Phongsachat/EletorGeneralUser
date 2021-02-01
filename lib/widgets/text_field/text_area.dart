import 'package:Eletor/widgets/text_field/text_field_container.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

class RoundedTextArea extends StatelessWidget {
  final double width, height, radius;
  final Color color;
  final String hintText;
  final TextEditingController controller;

  const RoundedTextArea({Key key,
    this.width,
    this.height,
    this.radius,
    this.color,
    this.controller,
    this.hintText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
        width: width ?? null,
        height: height ?? null,
        radius: radius ?? null,
        verticalSize: 0,
        color: color,
        child: TextFormField(
          keyboardType: TextInputType.multiline,
          style: TextStyle(
              fontFamily: primaryFontFamily,
              fontSize: 13,
              color: Colors.black,
              fontWeight: FontWeight.w600),
          maxLines: null,
          controller: controller,
          decoration: InputDecoration(
              hintStyle: TextStyle(
                  fontFamily: primaryFontFamily,
                  fontSize: 12,
                  color: hintTxtFieldColor ?? null),
              hintText: hintText ?? null,
              border: InputBorder.none
          ),
        ));
  }
}
