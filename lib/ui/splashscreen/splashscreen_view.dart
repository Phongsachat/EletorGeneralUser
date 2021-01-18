import 'package:Eletor/animation/animated_splash_screen.dart';
import 'package:Eletor/ui/splashscreen/splashscreen_view_model.dart';
import 'package:Eletor/utils/images_utils.dart';
import 'package:Eletor/widgets/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class SplashScreenView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SplashScreenView();
}

class _SplashScreenView extends State<SplashScreenView> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SplashScreenViewModel>.reactive(
        viewModelBuilder: () => SplashScreenViewModel(),
        onModelReady: (model) async{
          await model.checkAuthentication();
        },
        builder: (context, vm, child) => Scaffold(
          body: AnimatedSplashScreenCustom(
            splash: ImagesUtils.logo,
            backgroundColor: primaryColor,
            duration: 1000,
            splashSize: 200,
            isCurrentUser: vm.isAuthenticated,
          ),
        ));
  }
}
