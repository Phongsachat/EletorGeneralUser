import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

Shimmer loader(Widget widget) {
  return Shimmer.fromColors(
      child: widget,
      baseColor: Colors.white,
      highlightColor: Colors.grey[300]
  );
}
