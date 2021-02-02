import 'package:Eletor/navigations/routes.dart';
import 'package:Eletor/ui/home/home_view_model.dart';
import 'package:Eletor/utils/images_utils.dart';
import 'package:Eletor/utils/string_values.dart';
import 'package:Eletor/widgets/constants.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:provider/provider.dart';

import 'headerApp_view_model.dart';

class HeaderApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer2<HeaderAppViewModel,HomeViewModel>(
        builder: (context, vm1, vm2,child) => Column(
              children: [
                Container(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).padding.top +5,
                      left: 20.0,
                      right: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Row(
                            children: [
                              Container(
                                child: Image.asset(ImagesUtils.logo),
                                width: 50,
                                height: 50,
                              ),
                              Column(
                                children: [
                                  AutoSizeText(
                                    StringValue.appName,
                                    maxLines: 1,
                                    style: TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                  AutoSizeText(
                                    StringValue.objectDetection,
                                    maxLines: 1,
                                    style: TextStyle(
                                        fontSize: 1, color: Colors.white),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                      InkWell(
                        onTap: () async {

                          await vm1.signOut(vm2);

                          if (vm1.isLogOutSuccess) {
                            notificationSignOut();
                            Get.offNamed(Routes.SIGN_IN);
                          }
                        },
                        child: Icon(
                          Icons.exit_to_app_outlined,
                          color: Colors.white,
                          size: 30,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10),
              ],
            ));
  }

  notificationSignOut() {
    return showSimpleNotification(
      Text(
        StringValue.signOutSuccess,
        style: TextStyle(
          fontFamily: primaryFontFamily,
        ),
      ),
      duration: Duration(seconds: 2),
      background: Colors.green,);
  }
}
