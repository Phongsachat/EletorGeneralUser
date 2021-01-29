import 'package:Eletor/extensions/ContainerExtension.dart';
import 'package:Eletor/models/mission/mission_model.dart';
import 'package:Eletor/ui/loading/loading_view_model.dart';
import 'package:Eletor/ui/missioncards/mission_cards_view.dart';
import 'package:Eletor/ui/missioncards/mission_cards_view_model.dart';
import 'package:Eletor/utils/connectivity/connection.dart';
import 'package:Eletor/utils/googles/firestore.dart';
import 'package:Eletor/utils/shared_preference.dart';
import 'package:Eletor/utils/string_values.dart';
import 'package:Eletor/utils/values.dart';
import 'package:Eletor/widgets/constants.dart';
import 'package:Eletor/widgets/mission/mission_list.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:ndialog/ndialog.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:stacked/stacked.dart';

import 'home_view_model.dart';

// ignore: must_be_immutable
class HomeView extends StatelessWidget {
  FireStoreUtils _fireStoreUtils = FireStoreUtils("/mission");

  final String username;
  final String imageUrl;

  HomeView({this.username,this.imageUrl});


  @override
  Widget build(BuildContext context) {
    return Consumer<HomeViewModel>(builder: (context, vm1, child) {
      return ViewModelBuilder<ConnectionViewModel>.reactive(
          viewModelBuilder: () => ConnectionViewModel(),
          builder: (context, vm2, child) {
            print("home view isConnected : ${vm2.isConnected}");
            return Container(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Container(
                            padding: EdgeInsets.only(bottom: 65),
                            height: MediaQuery.of(context).size.height - 65,
                            width: MediaQuery.of(context).size.width,
                            child: Stack(
                              children: <Widget>[
                                Column(
                                  children: <Widget>[
                                    SizedBox(height: 30),
                                    Card(
                                      elevation: 8,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      color: Colors.white,
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            top: 32,
                                            bottom: 20,
                                            left: 10,
                                            right: 10),
                                        child: Center(
                                          child: Column(
                                            children: <Widget>[
                                              SizedBox(height: 35),
                                              AutoSizeText(
                                                username,
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 1,
                                                style: TextStyle(
                                                    fontFamily:
                                                    primaryFontFamily,
                                                    fontSize: 20,
                                                    fontWeight:
                                                    FontWeight.bold),
                                                textAlign: TextAlign.center,
                                              ),
                                              AutoSizeText(
                                                StringValue.generalUser,
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 1,
                                                style: TextStyle(
                                                    fontFamily:
                                                    primaryFontFamily,
                                                    fontSize: 15,
                                                    color: Colors.grey),
                                                textAlign: TextAlign.center,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Container(
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 35.0),
                                        child: Card(
                                          elevation: 8,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                            BorderRadius.circular(30),
                                          ),
                                          color: Colors.white,
                                          child: Column(
                                            children: [
                                              Row(
                                                children: [
                                                  Flexible(
                                                    child: ClipOval(
                                                      child: Container(
                                                        color: secondColor,
                                                        padding:
                                                        EdgeInsets.all(5),
                                                        child: Icon(
                                                          Icons
                                                              .track_changes_outlined,
                                                          size: 35,
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    flex: 2,
                                                    child: Align(
                                                      alignment:
                                                      Alignment.center,
                                                      child: AutoSizeText(
                                                        StringValue
                                                            .current_mission,
                                                        maxLines: 1,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: TextStyle(
                                                            fontFamily:
                                                            primaryFontFamily,
                                                            fontSize: 18,
                                                            fontWeight:
                                                            FontWeight
                                                                .bold),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      child: Expanded(
                                        child: AnimationLimiter(
                                          child: StreamBuilder<QuerySnapshot>(
                                            stream: _fireStoreUtils.snapshots(),
                                            builder: (BuildContext context,
                                                AsyncSnapshot<QuerySnapshot>
                                                snapshot) {
                                              return ListView.builder(
                                                  scrollDirection: Axis
                                                      .vertical,
                                                  itemCount:
                                                  (snapshot.data != null)
                                                      ? snapshot
                                                      .data.docs.length
                                                      : 0,
                                                  itemBuilder:
                                                      (context, index) {
                                                    var chunkMission = snapshot
                                                        .data.docs[index]
                                                        .data();
                                                    String locationName =
                                                    chunkMission[
                                                    'locationName'];
                                                    Timestamp situationTime =
                                                    chunkMission[
                                                    'startTimeStamp'];
                                                    String details =
                                                    chunkMission['details'];
                                                    GeoPoint latLng =
                                                    chunkMission['latLng'];
                                                    String photoURL =
                                                    chunkMission['imgSrc'];
                                                    String missionID =
                                                    chunkMission[
                                                    'missionId'];
                                                    int severityId =
                                                    chunkMission[
                                                    'severity'];
                                                    int missionStatus =
                                                    chunkMission[
                                                    'missionStatus'];
                                                    Timestamp finishTimeStamp =
                                                    chunkMission[
                                                    'finishTimeStamp'];
                                                    String missionReportId =
                                                    chunkMission[
                                                    'missionReportId'];
                                                    bool missionReportStatus =
                                                    chunkMission[
                                                    'missionReportStatus'];
                                                    // print(
                                                    //     "chunkMission test : $chunkMission");

                                                    // vm1.getCurrentWorking(missionID);

                                                    return (missionStatus == 1)
                                                        ? Container()
                                                        : AnimationConfiguration
                                                        .staggeredList(
                                                        position: index,
                                                        duration:
                                                        const Duration(
                                                            milliseconds:
                                                            200),
                                                        child:
                                                        SlideAnimation(
                                                          verticalOffset:
                                                          50.0,
                                                          child:
                                                          FadeInAnimation(
                                                              child:
                                                              Padding(
                                                                padding: const EdgeInsets
                                                                    .only(
                                                                    bottom:
                                                                    8.0),
                                                                child:
                                                                InkWell(
                                                                  child:
                                                                  MissionList(
                                                                    content:
                                                                    situationTime.toDateTime(),
                                                                    title:
                                                                    locationName,
                                                                    icon: Icons
                                                                        .description,
                                                                  ),
                                                                  onTap:
                                                                      () async {

                                                                    // isConnected!!!
                                                                    if(vm2.isConnected==true){
                                                                      print("homeView Select mission");
                                                                      vm1.changeHomeState(
                                                                          false);

                                                                      // EasyLoading
                                                                      //     .show();
                                                                      context
                                                                          .read<LoadingViewModel>()
                                                                          .showLoading();

                                                                      context
                                                                          .read<MissionCardsViewModel>()
                                                                          .initialize = missionID;

                                                                      MissionModel missionModel = MissionModel(
                                                                          locationName,
                                                                          situationTime.toDateTime(),
                                                                          details,
                                                                          photoURL,
                                                                          severityId,
                                                                          latLng,
                                                                          missionID,
                                                                          missionStatus,
                                                                          finishTimeStamp.toDateTime(),
                                                                          missionReportId,
                                                                          missionReportStatus);

                                                                      /*await vm1
                                                                          .checkingWasJoinMission(missionID);*/

                                                                        // EasyLoading
                                                                        //     .dismiss();
                                                                        context
                                                                            .read<LoadingViewModel>()
                                                                            .dismissLoading();

                                                                        Get.to(
                                                                            MissionCardsView(
                                                                              missionModel: missionModel,
                                                                            ),
                                                                            transition: Transition.downToUp);

                                                                    }else{
                                                                      reportDisconnected(context);
                                                                    }

                                                                  },
                                                                ),
                                                              )),
                                                        ));
                                                  });
                                            },
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                Container(
                                    alignment: Alignment.topCenter,
                                    height: 100.0,
                                    child: Container(
                                      width: 100,
                                      height: 100,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(50),
                                        child: (imageUrl != null)
                                            ? CachedNetworkImage(
                                          imageUrl: imageUrl,
                                          imageBuilder:
                                              (context, imageProvider) =>
                                              Container(
                                                decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                      image: imageProvider,
                                                      fit: BoxFit.cover,
                                                      colorFilter:
                                                      ColorFilter.mode(
                                                          Colors
                                                              .grey[200],
                                                          BlendMode
                                                              .colorBurn)),
                                                ),
                                              ),
                                          placeholder: (context, url) =>
                                              Shimmer.fromColors(
                                                  child: Container(
                                                    height: 100,
                                                    width: 100,
                                                    child: ClipRRect(
                                                      borderRadius:
                                                      BorderRadius
                                                          .circular(
                                                          50),
                                                      child: Container(
                                                        width: 100,
                                                        height: 100,
                                                        color: Colors
                                                            .grey[200],
                                                      ),
                                                    ),
                                                  ),
                                                  baseColor: Colors.white,
                                                  highlightColor:
                                                  Colors.grey[300]),
                                          errorWidget:
                                              (context, url, error) =>
                                              Icon(Icons.error),
                                        )
                                            : Shimmer.fromColors(
                                            child: Container(
                                              height: 100,
                                              width: 100,
                                              child: ClipRRect(
                                                borderRadius:
                                                BorderRadius.circular(
                                                    50),
                                                child: Container(
                                                  width: 100,
                                                  height: 100,
                                                  color: Colors.grey[200],
                                                ),
                                              ),
                                            ),
                                            baseColor: Colors.white,
                                            highlightColor:
                                            Colors.grey[300]),
                                      ),
                                    )),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          });
    });
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
            }),
      ],
    ).show(context);
  }
}

