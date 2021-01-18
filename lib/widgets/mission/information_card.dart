import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'mission_list.dart';

class InformationCard extends StatelessWidget {

  final double width;
  final double height;
  final int blurRadius;
  final int spreadRadius;
  final int radius;
  final String title;
  final String content;
  final int severityId;

  const InformationCard({Key key, this.width, this.height, this.blurRadius, this.spreadRadius, this.radius,@required this.title,@required this.content,this.severityId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height ?? 100,
      margin: EdgeInsets.only(left: 10, right: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(radius ?? 8)),
        boxShadow: [
          BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              blurRadius: blurRadius ?? 2,
              spreadRadius: spreadRadius ?? 0.5)
        ],
      ),
      child: MissionList(
        title: title,
        content: content,
        severityId: severityId,
        icon: Icons.map_outlined,
      ),
    );
  }
}
