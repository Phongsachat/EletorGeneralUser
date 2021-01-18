
import 'package:Eletor/ui/loading/loading_view_model.dart';
import 'package:Eletor/ui/menu/menu_view.dart';
import 'package:Eletor/ui/signin/sign_in_view_model.dart';
import 'package:Eletor/utils/connectivity/connection.dart';
import 'package:Eletor/utils/images_utils.dart';
import 'package:Eletor/utils/string_values.dart';
import 'package:Eletor/widgets/Loading/LoadingSpinkit.dart';
import 'package:Eletor/widgets/button/rounded_button.dart';
import 'package:Eletor/widgets/button/rounded_icon_button.dart';
import 'package:Eletor/widgets/constants.dart';
import 'package:Eletor/widgets/text_field/rounded_text_field.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:provider/provider.dart';
import 'package:stacked/stacked.dart';

class SignInView extends StatelessWidget {
  String _username;
  String _password;

  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery
        .of(context)
        .size;

    return ViewModelBuilder<ConnectionViewModel>.reactive(
        viewModelBuilder: () => ConnectionViewModel(),
        onModelReady: (model) async {
          await model.init();
        },
        builder: (context, vm1, child) =>
            Scaffold(
              body: ViewModelBuilder<SignInViewModel>.reactive(
                  viewModelBuilder: () => SignInViewModel(),
                  builder: (context, vm2, child) {
                    return Consumer<LoadingViewModel>(
                        builder: (context, states, child) {
                          return LoadingOverlay(
                            isLoading: states.isPageLoading,
                            progressIndicator: spinkitLoading,
                            color: overlayLoadingColor,
                            opacity: overlayLoadingOpacity,
                            child: WillPopScope(
                              onWillPop: () async {
                                Get.toEnd(() => SignInView());
                                return true;
                              },
                              child: GestureDetector(
                                onTap: () async {
                                  FocusScope.of(context).requestFocus(
                                      FocusNode());
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                      gradient: bgPrimary),
                                  child: SafeArea(
                                    child: Center(
                                      child: ListView(
                                        shrinkWrap: true,
                                        children: [
                                          Container(
                                            child: Column(
                                              children: [
                                                logoApp(),
                                                appName(),
                                                titleObjectDetection(),
                                              ],
                                            ),
                                          ),
                                          Container(
                                              margin: EdgeInsets.all(5),
                                              child: Column(
                                                children: [
                                                  SizedBox(width: 30, height: 50),
                                                  googleSignInButton(vm2)
                                                ],
                                              ))
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        }
                    );
                  }),
            ));
  }


  showNotification(String messages) {
    showSimpleNotification(
      Text(messages, style: TextStyle(
        fontFamily: primaryFontFamily,
      ),),
      duration: Duration(seconds: 2),
      background: Colors.red,);
  }


  RoundedIconButton googleSignInButton(SignInViewModel vm2) {
    return RoundedIconButton(
      text: StringValue.googleSignIn,
      icons: Image.asset(
        ImagesUtils.googleLogo,
        width: 25,
        height: 25,
      ),
      padding: EdgeInsets.all(5),
      height: 50,
      onTap: () async {
        EasyLoading.show();

        await vm2.signIn();

        if (await vm2.registerUser(vm2.user.providerData.first)) {
          EasyLoading.dismiss();

          String imageUrl = vm2.user.photoURL;
          String username = vm2.user.displayName;
          String uid = vm2.user.providerData.first.uid;

          await vm2.saveSharePref(uid);
          await vm2.saveUserInfo(username,imageUrl);

          Get.to(MenuView(imageUrl: imageUrl, username: username,));
        }
      },
    );
  }


  AutoSizeText titleObjectDetection() {
    return const AutoSizeText(StringValue.objectDetection,
        style: const TextStyle(fontSize: 12, color: Colors.white));
  }

  AutoSizeText appName() {
    return const AutoSizeText(StringValue.appName,
        style: const TextStyle(
            fontSize: 45, fontWeight: FontWeight.bold, color: Colors.white));
  }

  Container logoApp() {
    return Container(
      child: Image.asset(ImagesUtils.logo),
      width: 120,
      height: 120,
    );
  }
}
