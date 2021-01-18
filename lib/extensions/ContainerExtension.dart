import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

extension ContainerExtension on BoxDecoration {

  BoxDecoration shadow() => BoxDecoration(
      borderRadius: BorderRadius.circular(29),
      boxShadow: [_boxShadow()]
  );

  BoxShadow _boxShadow() => BoxShadow(
        color: Colors.black26,
        blurRadius: 5,
        spreadRadius: 0.5,
      );
}

extension DateTimeExtension on Timestamp{
  String toDateTime(){
    var format = DateFormat("d MMMM y, HH:mm");
    var currentMicroSecond = DateTime.now().microsecondsSinceEpoch;
    return format.format(DateTime.fromMicrosecondsSinceEpoch(this.microsecondsSinceEpoch ?? currentMicroSecond));
  }
}
