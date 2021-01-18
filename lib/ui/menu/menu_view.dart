import 'dart:developer';

import 'package:Eletor/ui/camera/camera_view.dart';
import 'package:Eletor/ui/history/history_view.dart';
import 'package:Eletor/ui/home/headerApp.dart';
import 'package:Eletor/ui/home/home_view.dart';
import 'package:Eletor/ui/loading/loading_view_model.dart';
import 'package:Eletor/utils/shared_preference.dart';
import 'package:Eletor/utils/string_values.dart';
import 'package:Eletor/utils/tabScroll.dart';
import 'package:Eletor/utils/values.dart';
import 'package:Eletor/widgets/Loading/LoadingSpinkit.dart';
import 'package:Eletor/widgets/constants.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:provider/provider.dart';
import 'package:stacked/stacked.dart';

import 'menu_view_model.dart';

class MenuView extends StatelessWidget {

  String username;
  String imageUrl;
  MenuView({this.username,this.imageUrl});

  @override
  Widget build(BuildContext context) {


    username = username ?? SharedPreferenceUtils.getString(Values.displayName);
    imageUrl = imageUrl ?? SharedPreferenceUtils.getString(Values.photoURL);

    return ViewModelBuilder<MenuViewModel>.reactive(
        viewModelBuilder: () => MenuViewModel(),
        builder: (context, vm, child) {
              return Consumer<LoadingViewModel>(
                builder: (context, states,child) {
                  return LoadingOverlay(
                    color: overlayLoadingColor,
                    opacity: overlayLoadingOpacity,
                    isLoading: states.isPageLoading,
                    progressIndicator: spinkitLoading,
                    child: Scaffold(
                      extendBody: true,
                      bottomNavigationBar: Container(
                        height: 65.0,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20.0),
                              topRight: Radius.circular(20.0),
                            ),
                          ),
                          child: CustomPaint(
                            painter: PageTabIndicationPainter(
                                pageController: vm.pageController),
                            child: Row(
                              children: [
                                Expanded(
                                  child: InkWell(
                                    onTap: () {
                                      vm.changePage(0);
                                    },
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(20.0),
                                        topRight: Radius.circular(20.0),
                                      ),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: [
                                          Expanded(
                                            child: iconMenu1,
                                          ),
                                          Expanded(
                                            child: AutoSizeText(
                                              "${StringValue.menu1}",
                                              maxLines: 1,
                                              style: TextStyle(
                                                  fontFamily: primaryFontFamily,
                                                  fontWeight: FontWeight.bold,
                                                fontSize: 3,),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: InkWell(
                                    onTap: () {
                                      vm.changePage(1);
                                    },
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(20.0),
                                        topRight: Radius.circular(20.0),
                                      ),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Expanded(
                                            child: iconMenu2,
                                          ),
                                          Expanded(
                                            child: AutoSizeText(
                                              "${StringValue.menu2}",
                                              maxLines: 1,
                                              style: TextStyle(
                                                  fontFamily: primaryFontFamily,
                                                  fontWeight: FontWeight.bold,
                                                fontSize: 3,),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: InkWell(
                                    onTap: () {
                                      vm.changePage(2);
                                    },
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(20.0),
                                        topRight: Radius.circular(20.0),
                                      ),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Expanded(
                                            child: iconMenu3,
                                          ),
                                          Expanded(
                                            child: AutoSizeText(
                                                "${StringValue.menu3}",
                                              maxLines: 1,
                                              style: TextStyle(
                                                  fontFamily: primaryFontFamily,
                                                  fontSize: 3,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      body: Container(
                        decoration: BoxDecoration(gradient: bgPrimary),
                        height: MediaQuery.of(context).size.height,
                        child: Column(
                          children: [
                            HeaderApp(),
                            Expanded(
                              child: PageView(
                                controller: vm.pageController,
                                onPageChanged: (index) {
                                  log("$index", name: "Current Index Page");
                                },
                                children: [
                                  HomeView(username: username,imageUrl: imageUrl),
                                  CameraView(username: username,imageUrl: imageUrl),
                                  HistoryView(),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }
              );
            }
          );

  }
}
