
import 'package:Eletor/utils/string_values.dart';
import 'package:Eletor/widgets/image/image_rounded_network.dart';
import 'package:Eletor/widgets/text/head_text.dart';
import 'package:Eletor/widgets/text_field/text_area.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class StateWritingComment extends StatelessWidget {
  final String imageUrl;
  final Function onTap;
  final TextEditingController controller;

  const StateWritingComment({Key key, this.imageUrl, this.onTap,this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight: 130
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(
              flex: 1,
              child: Container(
                padding: EdgeInsets.all(12),
                margin: EdgeInsets.only(bottom: 5),
                child: RoundedImageNetwork(
                  imageUrl: imageUrl,
                  width: 35,
                  height: 35,
                ),
              ),
            ),
            Expanded(
                flex: 4,
                child: RoundedTextArea(
                  radius: 8,
                  controller: controller,
                  color: Colors.grey[200],
                  hintText: StringValue.add_comment,
                  width: size.width * 0.6,
                )),
            Expanded(
              flex: 1,
              child: InkWell(
                onTap: () {
                  onTap();
                },
                child: Container(
                    padding: EdgeInsets.all(12),
                    margin: EdgeInsets.only(bottom: 10),
                    child: HeaderText(
                      title: StringValue.post,
                      size: 14,
                    )),
              ),
            )
          ],
        ),
      ),
    );
  }
}
