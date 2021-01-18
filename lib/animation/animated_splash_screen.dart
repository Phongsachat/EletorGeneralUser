import 'package:Eletor/ui/menu/menu_view.dart';
import 'package:Eletor/ui/signin/sign_in_view.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';

import '../widgets/constants.dart';

class AnimatedSplashScreenCustom extends StatelessWidget {
  final int duration;
  final double splashSize;
  final Future Function() function;
  final dynamic splash;
  final bool isCurrentUser;
  final Color backgroundColor;
  final bool center = true;
  final SplashTransition splashTransition;

  AnimatedSplashScreenCustom(
      {Key key,
      @required this.duration,
      this.splashSize,
      this.function,
      this.backgroundColor,
      @required this.splash,
      @required this.isCurrentUser,
      this.splashTransition});

  @override
  Widget build(BuildContext context) {

    return AnimatedSplashScreen(
      duration: duration,
      splashIconSize: splashSize,
      nextScreen: _nextScreens(isCurrentUser),
      splash: splash,
      backgroundColor: backgroundColor ?? primaryColor,
      function: function,
      splashTransition: splashTransition,
    );
  }

  Widget _nextScreens(bool isCurrentUser) =>
      (!isCurrentUser) ? SignInView() : MenuView();
}
