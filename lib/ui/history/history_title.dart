import 'package:Eletor/utils/string_values.dart';
import 'package:Eletor/widgets/constants.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HistoryTitle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.history,size: 40,color: Colors.white,),
          SizedBox(width: 5,),
          const AutoSizeText(StringValue.notify_history,
          style: TextStyle(
            fontFamily: primaryFontFamily,
            color: Colors.white,
            fontSize: 23,
            fontWeight: FontWeight.bold
          ),)
        ],
      ),
    );
  }
}
