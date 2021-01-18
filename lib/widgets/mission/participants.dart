import 'package:Eletor/widgets/image/image_rounded_network.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Participants extends StatefulWidget {
  final List<String> imageUrl;

  const Participants({Key key, @required this.imageUrl}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _Participants(imageUrl);
}

class _Participants extends State<Participants> {
  final List<String> imageUrl;

  _Participants(this.imageUrl);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GridView.builder(
        // Children control
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 5,
          mainAxisSpacing: size.height * 0.01,
          crossAxisSpacing: size.width * 0.01,
        ),
        itemCount: imageUrl.length,
        itemBuilder: (context, index) {
          return Container(
            child: RoundedImageNetwork(
              height: 10,
              width: 10,
              imageUrl: imageUrl[index],
            ),
          );
        });
  }
}
