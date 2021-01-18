import 'package:Eletor/utils/images_utils.dart';
import 'package:flutter/material.dart';

Widget roundedImage(
    {double radius, String imagePath, double height, double width}) {
  return Center(
    child: Container(
      width: width,
      height: height,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(radius),
        child:FadeInImage.assetNetwork(placeholder: ImagesUtils.placeholder, image: imagePath),
      ),
    ),
  );
}
