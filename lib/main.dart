import 'dart:io';

import 'package:Eletor/ui/camera/camera_send_mission.dart';
import 'package:Eletor/ui/camera/camera_view_model.dart';
import 'package:Eletor/ui/comment/comment_view_model.dart';
import 'package:Eletor/ui/home/headerApp_view_model.dart';
import 'package:Eletor/ui/home/home_view_model.dart';
import 'package:Eletor/ui/loading/loading_view_model.dart';
import 'package:Eletor/ui/menu/menu_view.dart';
import 'package:Eletor/ui/menu/menu_view_model.dart';
import 'package:Eletor/ui/missioncards/mission_cards_view.dart';
import 'package:Eletor/ui/missioncards/mission_cards_view_model.dart';
import 'package:Eletor/ui/signin/sign_in_view.dart';
import 'package:Eletor/ui/signin/sign_in_view_model.dart';
import 'package:Eletor/ui/splashscreen/splashscreen_view.dart';
import 'package:Eletor/ui/splashscreen/splashscreen_view_model.dart';
import 'package:Eletor/utils/connectivity/connection.dart';
import 'package:Eletor/utils/googles/firestore.dart';
import 'package:Eletor/utils/shared_preference.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:google_map_location_picker/generated/l10n.dart' as location_picker;
import 'package:overlay_support/overlay_support.dart';
import 'package:provider/provider.dart';

import 'navigations/routes.dart';

void main() {
  HttpOverrides.global = new MyHttpOverrides();
  runApp(MultiProvider(
    child: Eletor(),
    providers: [
      ChangeNotifierProvider(create: (_) => SplashScreenViewModel()),
      ChangeNotifierProvider(create: (_) => HomeViewModel()),
      ChangeNotifierProvider(create: (_) => MenuViewModel()),
      ChangeNotifierProvider(create: (_) => CameraViewModel()),
      ChangeNotifierProvider(create: (_) => ConnectionViewModel()),
      ChangeNotifierProvider(create: (_) => CommentViewModel()),
      ChangeNotifierProvider(create: (_) => MissionCardsViewModel()),
      ChangeNotifierProvider(create: (_) => HeaderAppViewModel()),
      ChangeNotifierProvider(create: (_) => SignInViewModel()),
      ChangeNotifierProvider(create: (_) => LoadingViewModel()),
    ],
  ));
}

class Eletor extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _Eletor();
}

class _Eletor extends State<Eletor> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));
    return OverlaySupport(
      child: GetMaterialApp(
        localizationsDelegates: [
          location_picker.S.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: [
          const Locale('th', ''),
        ],
        home: SplashScreenView(),
        getPages: [
          GetPage(name: Routes.SPLASH_SCREEN, page: () => SplashScreenView()),
          GetPage(name: Routes.MENU, page: () => MenuView()),
          GetPage(name: Routes.MISSION_CARD, page: () => MissionCardsView()),
          GetPage(
              name: Routes.CAMERA_SEND_MISSION,
              page: () => CameraSendMission()),
          GetPage(name: Routes.SIGN_IN, page: () => SignInView())
        ],
        debugShowCheckedModeBanner: false,
        builder: (context, child) {
          return FlutterEasyLoading(
              child: ScrollConfiguration(
            behavior: MyBehavior(),
            child: child,
          ));
        },
      ),
    );
  }

  @override
  void initState() {
    super.initState();

    // Intl.defaultLocale = "th";
    // initializeDateFormatting();

    FireStoreUtils.initialize;
    EasyLoading.instance..indicatorType = EasyLoadingIndicatorType.chasingDots;

    SharedPreferenceUtils.initialize();
  }
}

class MyBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
