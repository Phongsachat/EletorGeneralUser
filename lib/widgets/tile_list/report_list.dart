import 'dart:math';

import 'package:Eletor/ui/history/history_view_model.dart';
import 'package:Eletor/widgets/constants.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class ReportTile extends StatelessWidget {
  final String locationName;
  final int reportStatus;
  final Timestamp timeStamp;

  const ReportTile(
      {Key key, this.locationName, this.reportStatus, this.timeStamp})
      : super(key: key);


  @override
  Widget build(BuildContext context) {
    //Initial Value

    return Consumer<HistoryViewModel>(builder: (context, states, child) {
      states.maxLength(locationName);
      states.convertTimeStamp(timeStamp.millisecondsSinceEpoch);
      return Container(
        height: 70,
        padding: EdgeInsets.all(5.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              blurRadius: 5.0,
              offset: Offset(0, 1),
            ),
          ],
        ),
        child: Row(
          children: <Widget>[
            Expanded(
              flex: 2,
              child: Container(
                padding: EdgeInsets.only(left: 16),
                width: MediaQuery
                    .of(context)
                    .size
                    .width - 100,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    AutoSizeText(
                      '${states.maxLengthLocationName}',
                      maxLines: 2,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          fontFamily: primaryFontFamily,
                          fontWeight: FontWeight.w600),
                    ),
                    Row(
                      children: <Widget>[
                        SizedBox(
                          width: 4,
                        ),
                        Expanded(
                          child: AutoSizeText(
                            '${states.stringTimeStamp}',
                            maxLines: 1,
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 12,
                              fontFamily: primaryFontFamily,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 4,
                    ),
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
                  height: 100,
                  width: 120,
                  child: checkStatus(reportStatus),
                ),
              ),
            ),

          ],
        ),
      );
    }
    );
  }

  Widget checkStatus(int reportStatus) {
    switch (reportStatus) {
      case 0 :
        {
          return sendSuccess();
        }
        break;
      case 1 :
        {
          return onProcess();
        }
        break;
      case 2 :
        {
          return missionComplete();
        }
        break;
      default :
        return Text("ERROR");
    }
  }


  Widget sendSuccess() {
    return Row(
      children: [
        Transform.rotate(
          angle: -100 * pi / 360,
          child: Icon(
            Icons.send,
            color: Colors.blue,
          ),),
        Flexible(
          child: Container(
            child: Text(
              "ส่งรายงานแล้ว",
              maxLines: 1,
              style: TextStyle(
                fontFamily: primaryFontFamily,
                fontWeight: FontWeight.bold,
                color: sendReportColor,
              ),
            ),
          ),)
      ],
    );
  }

  Widget onProcess() {
    return Row(
      children: [
        Icon(
          Icons.hourglass_empty_outlined,

          color: Colors.yellow,
        ),
        Flexible(
          child: Container(
            child: Text(
              "กำลังดำเนินการ",
              maxLines: 1,
              style: TextStyle(
                fontFamily: primaryFontFamily,
                fontWeight: FontWeight.bold,
                color: onProcessColor,
              ),
            ),
          ),)
      ],
    );
  }

  Widget missionComplete() {
    return Row(
      children: [
        Icon(
          Icons.check_box_outlined,
          color: Colors.green,
        ),
        Flexible(
          child: Container(
            child: Text(
              "ภารกิจสำเเร็จ",
              maxLines: 1,
              style: TextStyle(
                fontFamily: primaryFontFamily,
                fontWeight: FontWeight.bold,
                color: missionCompleteColor,
              ),
            ),
          ),)
      ],
    );
  }
}