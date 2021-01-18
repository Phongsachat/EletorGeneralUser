import 'dart:io';

import 'package:Eletor/ui/camera/camera_view_model.dart';
import 'package:Eletor/utils/string_values.dart';
import 'package:Eletor/widgets/constants.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

import 'camera_send_mission.dart';

class CameraView extends StatelessWidget {

  final String username;
  final String imageUrl;

  CameraView({this.username,this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Consumer<CameraViewModel>(builder: (context, states, child) {
      return Scaffold(
        body: Container(
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Color(0xff4D5B26), Color(0xffC1DE70)])),
          child: SingleChildScrollView(
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    child: Container(
                      child: states.imagesFile == null
                          ? notHaveImage(context, states)
                          : haveImage(context, states.imagesFile, states),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }

  showChoiceDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return Consumer<CameraViewModel>(
              builder: (context, states, child) {
            return AlertDialog(
              title: AutoSizeText(
                StringValue.sourceByGalleryOrCamera,
                maxLines: 1,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontFamily: primaryFontFamily,
                    fontWeight: FontWeight.bold),
              ),
              content: SingleChildScrollView(
                child: ListBody(
                  children: [
                    GestureDetector(
                      child: AutoSizeText(
                        StringValue.gallery,
                        maxLines: 1,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontFamily: primaryFontFamily,
                            fontWeight: FontWeight.bold),
                      ),
                      onTap: () async {
                        await Permission.storage.request();
                        var status = await Permission.storage.status;
                        if (status.isGranted) {
                          states.openGallery(context);
                        } else {
                          permissionStorage(context, states);
                        }
                      },
                    ),
                    Padding(padding: EdgeInsets.all(8)),
                    GestureDetector(
                      child: AutoSizeText(
                        StringValue.camera,
                        maxLines: 1,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontFamily: primaryFontFamily,
                            fontWeight: FontWeight.bold),
                      ),
                      onTap: () async {
                        await Permission.camera.request();
                        var status = await Permission.camera.status;
                        if (status.isGranted) {
                          states.openCamera(context);
                        } else {
                          permissionCamera(context, states);
                        }
                      },
                    )
                  ],
                ),
              ),
            );
          });
        });
  }

  Widget haveImage(BuildContext context, File imagesFile ,states) {
      return Column(children: [
        Container(
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.only(top: 0),
              child: Container(
                height: MediaQuery.of(context).size.height / 1.60,
                color: Colors.black,
                child: Column(children: [
                  Image.file(
                    imagesFile,
                    height: MediaQuery.of(context).size.height / 1.60,
                  ),
                ]),
              ),
            )),
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 30, 0, 30),
          child: Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                  child: ClipOval(
                    child: Material(
                      color: Colors.white, // button color
                      child: InkWell(
                        splashColor: Colors.red, // inkwell color
                        child: SizedBox(
                            width: MediaQuery.of(context).size.height / 10,
                            height: MediaQuery.of(context).size.height / 10,
                            child: Icon(Icons.clear_rounded)),
                        onTap: () {
                          states.clearData();
                        },
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                  child: ClipOval(
                    child: Material(
                      color: Colors.white, // button color
                      child: InkWell(
                        splashColor: Colors.green, // inkwell color
                        child: SizedBox(
                            width: MediaQuery.of(context).size.height / 10,
                            height: MediaQuery.of(context).size.height / 10,
                            child: Icon(Icons.send_rounded)),
                        onTap: () {
                          Get.to(CameraSendMission(username: username,imageUrl: imageUrl));
                        },
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ]);
  }

  Widget notHaveImage(BuildContext context, states) {
    return Column(children: [
      Padding(
          padding: const EdgeInsets.only(top: 0),
          child: Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height / 1.60,
            color: Colors.white,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.wallpaper_rounded,
                    size: MediaQuery.of(context).size.height / 4,
                    color: Colors.black),
                AutoSizeText(
                  StringValue.sourceByGalleryOrCamera,
                  maxLines: 1,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontFamily: primaryFontFamily,
                      fontWeight: FontWeight.bold),
                )
              ],
            ),
          )),
      Padding(
        padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
        child: Container(
          child: ClipOval(
            child: Material(
              color: Colors.white, // button color
              child: InkWell(
                splashColor: Colors.green, // inkwell color
                child: SizedBox(
                    width: MediaQuery.of(context).size.height / 10,
                    height: MediaQuery.of(context).size.height / 10,
                    child: Icon(Icons.camera_alt_rounded)),
                onTap: () async {
                  await Permission.location.request();
                  var status = await Permission.location.status;
                  if (status.isGranted) {
                    showChoiceDialog(context);
                  } else {
                    permissionLocation(context);
                  }
                },
              ),
            ),
          ),
        ),
      ),
    ]);
  }

  permissionCamera(context, states) async {
    showDialog(
        context: context,
        builder: (BuildContext context) => CupertinoAlertDialog(
          title: Text(StringValue.cameraPermissionTitle,
              style: TextStyle(
                  fontFamily: primaryFontFamily,
                  fontSize: 15,
                  color: Colors.black,
                  fontWeight: FontWeight.bold)),
          content: Text(StringValue.cameraPermissionDetails,
              style: TextStyle(
                  fontFamily: primaryFontFamily,
                  fontSize: 15,
                  color: Colors.grey)),
          actions: <Widget>[
            CupertinoDialogAction(
              child: Text(StringValue.cancel,
                  style: TextStyle(
                      fontFamily: primaryFontFamily,
                      fontSize: 15,
                      color: Colors.black,
                      fontWeight: FontWeight.bold)),
              onPressed: () => Navigator.of(context).pop(),
            ),
            CupertinoDialogAction(
                child: Text(StringValue.setting,
                    style: TextStyle(
                        fontFamily: primaryFontFamily,
                        fontSize: 15,
                        color: Colors.black,
                        fontWeight: FontWeight.bold)),
                onPressed: () {
                  openAppSettings();
                }),
          ],
        ));
  }

  permissionStorage(context, states) {
    showDialog(
        context: context,
        builder: (BuildContext context) => CupertinoAlertDialog(
          title: Text(StringValue.storagePermissionTitle,
              style: TextStyle(
                  fontFamily: primaryFontFamily,
                  fontSize: 15,
                  color: Colors.black,
                  fontWeight: FontWeight.bold)),
          content: Text(StringValue.storagePermissionDetails,
              style: TextStyle(
                  fontFamily: primaryFontFamily,
                  fontSize: 15,
                  color: Colors.grey)),
          actions: <Widget>[
            CupertinoDialogAction(
              child: Text(StringValue.cancel,
                  style: TextStyle(
                      fontFamily: primaryFontFamily,
                      fontSize: 15,
                      color: Colors.black,
                      fontWeight: FontWeight.bold)),
              onPressed: () => Navigator.of(context).pop(),
            ),
            CupertinoDialogAction(
                child: Text(StringValue.setting,
                    style: TextStyle(
                        fontFamily: primaryFontFamily,
                        fontSize: 15,
                        color: Colors.black,
                        fontWeight: FontWeight.bold)),
                onPressed: () {
                  openAppSettings();
                }),
          ],
        ));
  }

  permissionLocation(context) async {
    showDialog(
        context: context,
        builder: (BuildContext context) => CupertinoAlertDialog(
          title: Text(StringValue.locationPermissionTitle,
              style: TextStyle(
                  fontFamily: primaryFontFamily,
                  fontSize: 15,
                  color: Colors.black,
                  fontWeight: FontWeight.bold)),
          content: Text(StringValue.locationPermissionDetails,
              style: TextStyle(
                  fontFamily: primaryFontFamily,
                  fontSize: 15,
                  color: Colors.grey)),
          actions: <Widget>[
            CupertinoDialogAction(
              child: Text(StringValue.cancel,
                  style: TextStyle(
                      fontFamily: primaryFontFamily,
                      fontSize: 15,
                      color: Colors.black,
                      fontWeight: FontWeight.bold)),
              onPressed: () => Navigator.of(context).pop(),
            ),
            CupertinoDialogAction(
                child: Text(StringValue.setting,
                    style: TextStyle(
                        fontFamily: primaryFontFamily,
                        fontSize: 15,
                        color: Colors.black,
                        fontWeight: FontWeight.bold)),
                onPressed: () async {
                    openAppSettings();
                }),
          ],
        ));
  }
}
