import 'package:Eletor/utils/string_values.dart';
import 'package:Eletor/widgets/constants.dart';
import 'package:flutter/material.dart';
import 'package:ndialog/ndialog.dart';

class DialogAlert {
  dialogNotify(BuildContext context, String title, String content,
      Color alertColor) async {
    return await NDialog(
      dialogStyle: DialogStyle(titleDivider: true),
      title: Text(title,
          textAlign: TextAlign.center,
          style: TextStyle(
              fontFamily: primaryFontFamily,
              fontSize: 18,
              color: alertColor,
              fontWeight: FontWeight.bold)),
      content: Text(content,
          textAlign: TextAlign.center,
          style: TextStyle(
              fontFamily: primaryFontFamily,
              fontSize: 15,
              color: Colors.black,
              fontWeight: FontWeight.normal)),
      actions: [
        FlatButton(
            child: Text(StringValue.accept,
                style: TextStyle(
                    fontFamily: primaryFontFamily,
                    fontSize: 15,
                    color: Colors.black,
                    fontWeight: FontWeight.bold)),
            shape: RoundedRectangleBorder(
              side: BorderSide(
                  color: Colors.grey[200], width: 1, style: BorderStyle.solid),
            ),
            onPressed: () {
              Navigator.of(context).pop();
            }),
      ],
    ).show(context);
  }
}
