import 'package:Eletor/widgets/constants.dart';
import 'package:Eletor/widgets/image/image_rounded_network.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ImagesStack extends StatelessWidget {
  final List<String> images;

  const ImagesStack({Key key, @required this.images}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final String _imageLength = "+${images.length - 1 }";
    return Stack(
      children: [
        (images.length != 1) ? Container(
                margin: EdgeInsets.only(left: size.width * 0.04),
                padding: EdgeInsets.only(left: 2.5),
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey, blurRadius: 2, spreadRadius: 0.2)
                    ]),
                child: Center(
                    child: AutoSizeText(
                  _imageLength,
                  style: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.w600,
                      fontSize: 2,
                      fontFamily: primaryFontFamily),
                )),
              ) : Container(),
        RoundedImageNetwork(imageUrl: images[0])
      ],
    );
  }
}
