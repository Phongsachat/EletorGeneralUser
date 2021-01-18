import 'package:Eletor/widgets/severitylevels/severity_levels.dart';
import 'package:Eletor/widgets/text/head_text.dart';
import 'package:Eletor/widgets/text/time_text_notify.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MissionList extends StatelessWidget {
  final double size;
  final String title;
  final String content;
  final IconData icon;
  final int severityId;

  const MissionList({Key key, this.size,@required this.title,@required this.content,@required this.icon,this.severityId}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;

    return Container(
      height: 70,
      padding: EdgeInsets.all(5.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 2,
            child: Container(
              padding: EdgeInsets.only(left: 16),
              width: MediaQuery.of(context).size.width - 100,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  (severityId!=null)?
                  Container(padding: EdgeInsets.only(bottom: 5),
                      child: SeverityLevels(levels: (severityId==1)? Levels.HIGH : Levels.LOW).severityWidget()) :Container(),
                  HeaderText(title: title),
                  Row(
                    children: <Widget>[
                      SizedBox(width: 4,),
                      Expanded(child: TimeNotifyText(text: content,)),
                    ],
                  ),
                  SizedBox(height: 4,),
                ],
              ),
            ),
          ),
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(8),
                bottomRight: Radius.circular(8),
              ),
              child: Container(
                padding: EdgeInsets.only(left: size.width * 0.15),
                height: 100,
                width: 120,
                child: Icon(icon,size: 35,),
              ),
            ),
          ),

        ],
      ),
    );
  }
}
