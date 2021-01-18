import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class RoundedImageNetwork extends StatelessWidget {
  final String imageUrl;
  final double width;
  final double height;

  const RoundedImageNetwork({Key key, this.imageUrl, this.width, this.height})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? 20,
      height: height ?? 20,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(50),
        child: CachedNetworkImage(
          imageUrl:
          imageUrl,
          imageBuilder:
              (context, imageProvider) =>
              Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: imageProvider,
                      fit: BoxFit.cover,
                      colorFilter:
                      ColorFilter.mode(
                          Colors
                              .grey[200],
                          BlendMode
                              .colorBurn)),
                ),
              ),
          placeholder: (context, url) =>
              Shimmer.fromColors(
                  child: Container(
                    height: 100,
                    width: 100,
                    child: ClipRRect(
                      borderRadius:
                      BorderRadius.circular(
                          50),
                      child: Container(
                        width: 100,
                        height: 100,
                        color: Colors.grey[200],
                      ),
                    ),
                  ),
                  baseColor: Colors.white,
                  highlightColor:
                  Colors.grey[300]),
          errorWidget:
              (context, url, error) =>
              Icon(Icons.error),
        ),

      ),
    );
  }
}