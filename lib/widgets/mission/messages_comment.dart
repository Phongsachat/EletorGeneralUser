import 'package:Eletor/widgets/constants.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MessagesComment extends StatelessWidget {

  final String userName;
  final String comment;

  const MessagesComment({Key key,@required this.userName,@required this.comment}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    // Size size = MediaQuery.of(context).size;

    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
             AutoSizeText(
              userName,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                  color: Colors.black,
                  fontFamily: primaryFontFamily,
                  fontSize: 13,
                  fontWeight: FontWeight.bold),
          ),
        AutoSizeText(
              comment,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: Colors.black,
                fontFamily: primaryFontFamily,
                fontSize: 12,
              ),
            ),
        ],
      ),
    );
  }
}
