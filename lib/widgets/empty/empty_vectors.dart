import 'package:Eletor/utils/images_utils.dart';
import 'package:flutter/cupertino.dart';

class EmptyVector extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
   return Container(
     child: Image.asset(ImagesUtils.emptyVector),
   );
  }
  
}