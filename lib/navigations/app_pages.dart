import 'package:Eletor/navigations/routes.dart';
import 'package:Eletor/ui/home/home_view.dart';
import 'package:Eletor/ui/splashscreen/splashscreen_view.dart';
import 'package:get/get.dart';

abstract class AppPages {
  static final pages = [
    GetPage(name: Routes.SPLASH_SCREEN, page: () => SplashScreenView()),
    GetPage(name: Routes.HOME, page: () => HomeView())
  ];
}
