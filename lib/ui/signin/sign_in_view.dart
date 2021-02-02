
import 'package:Eletor/ui/loading/loading_view_model.dart';
import 'package:Eletor/ui/menu/menu_view.dart';
import 'package:Eletor/ui/signin/sign_in_view_model.dart';
import 'package:Eletor/utils/connectivity/connection.dart';
import 'package:Eletor/utils/images_utils.dart';
import 'package:Eletor/utils/string_values.dart';
import 'package:Eletor/widgets/Loading/LoadingSpinkit.dart';
import 'package:Eletor/widgets/button/rounded_icon_button.dart';
import 'package:Eletor/widgets/constants.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:ndialog/ndialog.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:provider/provider.dart';
import 'package:stacked/stacked.dart';

class SignInView extends StatelessWidget {

  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Consumer<ConnectionViewModel>(
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
                                                  googleSignInButton(vm2,states,vm1,context)
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


  RoundedIconButton googleSignInButton(SignInViewModel vm2, states, vm1,context) {
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
        states.showLoading();

        // isConnected!!!
        if(vm1.isConnected==false){
          reportDisconnected(context);
        }else{
          await vm2.signIn();
          //EasyLoading.show();
          if(!vm2.user.isNull){
            if(await vm2.registerUser(vm2.user.providerData.first)){
              //EasyLoading.dismiss();
              states.dismissLoading();

              String imageUrl = vm2.user.photoURL;
              String username = vm2.user.displayName;
              String uid = vm2.user.providerData.first.uid;

              await vm2.saveSharePref(uid);
              await vm2.saveUserInfo(username,imageUrl);

              Get.off(MenuView(imageUrl: imageUrl, username: username,));
            }else{
              states.dismissLoading();
            }
          }else{
            states.dismissLoading();
          }
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

  reportDisconnected(BuildContext context) {
    NDialog(
      dialogStyle: DialogStyle(titleDivider: true),
      title: Text(StringValue.reportDisconnectedTitle,
          textAlign: TextAlign.center,
          style: TextStyle(
              fontFamily: primaryFontFamily,
              fontSize: 18,
              color: Colors.red,
              fontWeight: FontWeight.bold)),
      content: Text(StringValue.reportDisconnectedDetails,
          textAlign: TextAlign.center,
          style: TextStyle(
              fontFamily: primaryFontFamily,
              fontSize: 15,
              color: Colors.black,
              fontWeight: FontWeight.normal)),
      actions: [
        FlatButton(
            child: Text(StringValue.accept,
                style: TextStyle(
                    fontFamily: primaryFontFamily,
                    fontSize: 15,
                    color: Colors.black,
                    fontWeight: FontWeight.bold)),
            shape: RoundedRectangleBorder(
              side: BorderSide(
                  color: Colors.grey[200], width: 1, style: BorderStyle.solid),
            ),
            onPressed: () {
              Navigator.of(context).pop();
              Provider.of<LoadingViewModel>(context, listen: false)
                  .dismissLoading();
            }),
      ],
    ).show(context);
  }
}
