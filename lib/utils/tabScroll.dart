
import 'package:Eletor/widgets/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PageTabIndicationPainter extends CustomPainter {
  final PageController pageController;

  PageTabIndicationPainter({this.pageController})
      : super(repaint: pageController);

  @override
  void paint(Canvas canvas, Size size) {
    double pageOffset = 0;
    if (pageController.hasClients) {
      final position = pageController.position;

      double fullExtent = (position.maxScrollExtent -
          position.minScrollExtent +
          position.viewportDimension);
      pageOffset = position.extentBefore / fullExtent;
      //print("pageOffset: $pageOffset");
      //print("position: ${position.viewportDimension}");
    }

    Paint painterIndicator = Paint()
      ..color = secondColor
      ..style = PaintingStyle.fill;
      // ..maskFilter = MaskFilter.blur(BlurStyle.normal, convertRadiusToSigma(3));
    canvas.drawRRect(
        RRect.fromRectAndCorners(
            Rect.fromLTWH(pageOffset * size.width, 0, (size.width / 3), 65.0),
            topRight: Radius.circular(20),
            topLeft: Radius.circular(20)),
        painterIndicator);
    canvas.translate(size.width * pageOffset, 0.0);
  }

  static double convertRadiusToSigma(double radius) {
    return radius * 0.57735 + 0.5;
  }

  @override
  bool shouldRepaint(PageTabIndicationPainter oldDelegate) => true;
}
