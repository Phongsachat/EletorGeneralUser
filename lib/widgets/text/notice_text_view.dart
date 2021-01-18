import 'package:Eletor/widgets/text/content_detail_popup.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ContentTextBox extends StatelessWidget {
  final String content;
  final int maxLines;
  final double margin;
  final double padding;
  final double width;
  final double height;

  const ContentTextBox(
      {Key key,
      this.content,
      this.maxLines,
      this.width,
      this.height,
      this.margin,
      this.padding})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Center(
      child: Container(
        margin:  EdgeInsets.all(margin ?? 10),
        padding: EdgeInsets.all(padding ?? 5),
        height: height ?? size.height * 0.09,
        width: width ?? size.width * 0.7,
        decoration: BoxDecoration(color: Colors.grey[200], borderRadius: BorderRadius.circular(3)),
        child: ContentStyle(
          content: content,
          maxLines: maxLines,
        ),
      ),
    );
  }
}
