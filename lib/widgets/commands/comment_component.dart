import 'package:Eletor/widgets/image/image_rounded_network.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

class CommentComponent extends StatelessWidget {
  final String imageUrl;
  final String account;
  final String comment;

  const CommentComponent({Key key,@required this.imageUrl,@required this.account,@required this.comment}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            child: RoundedImageNetwork(
              imageUrl: imageUrl,
              width: 35,
              height: 35,
            ),
          ),
          Expanded(child: Container(
            padding: const EdgeInsets.only(left: 10,bottom: 3,top: 3,right: 3),
          margin: const EdgeInsets.only(left: 5,right: 10),
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(8)
          ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AutoSizeText(
                  account,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                      color: Colors.black,
                      fontFamily: primaryFontFamily,
                      fontSize: 14,
                      fontWeight: FontWeight.bold),
                ),
                AutoSizeText(
                  comment,
                  style:const TextStyle(fontFamily: primaryFontFamily, fontSize: 13),
                )
              ],
            ),
          ))
        ],
      ),
    );
  }
}
