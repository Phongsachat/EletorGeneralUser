import 'package:Eletor/utils/string_values.dart';
import 'package:Eletor/widgets/image/stack_images.dart';
import 'package:Eletor/widgets/mission/participants.dart';
import 'package:Eletor/widgets/text/head_text.dart';
import 'package:Eletor/widgets/text/notice_text_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NoticeCards extends StatelessWidget {
  final double width;
  final double height;
  final double radius;
  final int blurRadius;
  final int spreadRadius;
  final String text;
  final String content;
  final List<String> images;

  const NoticeCards({Key key,
    this.width,
    this.height,
    this.radius,
    this.blurRadius,
    this.spreadRadius,
    this.text,
    @required this.images,
    @required this.content})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery
        .of(context)
        .size;

    return Container(
      width: width,
      height: height,
      margin: EdgeInsets.only(left: 10, right: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(radius ?? 8)),
        boxShadow: [
          BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              blurRadius: blurRadius ?? 5,
              spreadRadius: spreadRadius ?? 0.5)
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.only(
                    left: size.width * 0.06, top: size.height * 0.01),
                child: HeaderText(title: text),
              ),
              Container(
                margin: EdgeInsets.only(left: size.width * 0.48, top: size.height * 0.01),
                child: InkWell(
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                    padding: EdgeInsets.only(
                                        bottom: size.height * 0.02),
                                    child: HeaderText(title: StringValue
                                        .mission_participants)),
                                SizedBox(
                                  height: size.height * 0.5,
                                  child: (images.isNotEmpty)? Participants(
                                    imageUrl: images,
                                  ):Container(),
                                ),
                              ],
                            ),
                          );
                        });
                  },
                  child: (images.isNotEmpty)? ImagesStack(
                    images: images,
                  ):Container(),
                ),
              )
            ],
          ),
          Container(
            child: InkWell(
              onTap: () {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            ContentTextBox(
                              content: content,
                              maxLines: 20,
                              height: size.height * 0.6,
                              margin: 0,
                            ),
                          ],
                        ),
                      );
                    });
              },
              child: ContentTextBox(
                content: content,
                maxLines: 3,
                width: size.width * 0.8,
              ),
            ),
          )
        ],
      ),
    );
  }
}
