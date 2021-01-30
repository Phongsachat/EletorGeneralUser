
import 'package:Eletor/models/mission/mission_model.dart';
import 'package:Eletor/ui/loading/loading_view_model.dart';
import 'package:Eletor/ui/missioncards/mission_cards_view_model.dart';
import 'package:Eletor/utils/string_values.dart';
import 'package:Eletor/widgets/Loading/LoadingSpinkit.dart';
import 'package:Eletor/widgets/button/rounded_button.dart';
import 'package:Eletor/widgets/constants.dart';
import 'package:Eletor/widgets/image/image_rounded.dart';
import 'package:Eletor/widgets/mission/comments_card.dart';
import 'package:Eletor/widgets/mission/information_card.dart';
import 'package:Eletor/widgets/mission/information_card_mission.dart';
import 'package:Eletor/widgets/mission/notice_card.dart';
import 'package:Eletor/widgets/shimmerloader/shimmer_loader.dart';
import 'package:Eletor/widgets/text/head_text.dart';
import 'package:Eletor/widgets/text/time_text_notify.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:ndialog/ndialog.dart';
import 'package:provider/provider.dart';

class MissionCardsView extends StatelessWidget {
  final MissionModel missionModel;

  MissionCardsView({Key key, this.missionModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Consumer<MissionCardsViewModel>(
      builder: (context, vm, child) {
        return Scaffold(
          appBar: AppBar(
            title: AutoSizeText(
              StringValue.current_mission,
              style: TextStyle(fontFamily: primaryFontFamily),
            ),
            backgroundColor: primaryColor,
          ),
          body: LoadingOverlay(
            isLoading: context.watch<LoadingViewModel>().isAcceptMissionLoading,
            progressIndicator: spinkitLoading,
            color: overlayLoadingColor,
            opacity: overlayLoadingOpacity,
            child: Container(
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(gradient: bgPrimary),
                  ),
                  Expanded(
                      child: ListView(
                    shrinkWrap: true,
                    children: [
                      (!vm.isLoading)
                          ? Container(
                              margin:
                                  EdgeInsets.only(left: 10, right: 10, top: 10),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8)),
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      blurRadius: 2,
                                      spreadRadius: 0.5)
                                ],
                              ),
                              child: roundedImage(
                                imagePath: missionModel.photoURL,
                                radius: 8,
                                width: size.width,
                                height: 250.0
                              ),
                            )
                          : loader(
                              _loadingComment(size.width, size.height * 0.35)),
                      InkWell(
                        onTap: () {
                          NDialog(
                            title: Text(missionModel.locationName,
                                textAlign: TextAlign.center,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontFamily: primaryFontFamily,
                                    fontSize: 18,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold)),
                            content: Container(
                              height: 200,
                              child: Column(
                                children: [
                                  Text(
                                    missionModel.situationTime,
                                    maxLines: 1,
                                    style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.grey,
                                        fontFamily: primaryFontFamily),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Flexible(
                                    child: ClipRRect(
                                      borderRadius:
                                      BorderRadius.all(Radius.circular(8)),
                                      child: GoogleMap(
                                          initialCameraPosition: CameraPosition(
                                              target: LatLng(
                                                  missionModel.latLng.latitude,
                                                  missionModel
                                                      .latLng.longitude),
                                              zoom: 16),
                                          markers: Set.from(setMark(
                                              missionModel.latLng.latitude,
                                              missionModel.latLng.longitude,
                                              StringValue.mapMissionCard)),
                                          mapType: MapType.normal,
                                          onMapCreated:
                                              (GoogleMapController controller) {
                                            vm.mapController
                                                .complete(controller);
                                          }),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            actions: [
                              FlatButton(
                                  child: Text(StringValue.accept,
                                      style: TextStyle(
                                          fontFamily: primaryFontFamily,
                                          fontSize: 15,
                                          color: btnAccept,
                                          fontWeight: FontWeight.bold)),
                                  shape: RoundedRectangleBorder(
                                    side: BorderSide(
                                        color: Colors.grey[200],
                                        width: 1,
                                        style: BorderStyle.solid),
                                  ),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  }),
                            ],
                          ).show(context);
                        },
                        child: (!vm.isLoading)
                            ? Container(
                                margin: EdgeInsets.only(
                                  top: 12,
                                ),
                                child: InformationCard(
                                  title: missionModel.locationName,
                                  severityId: missionModel.severityId,
                                  content: missionModel.situationTime,
                                ),
                              )
                            : loader(_loadingComment(size.width, 80)),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Container(
                        child: (!vm.isLoading)
                            ? NoticeCards(
                                text: StringValue.detail,
                                height: size.height * 0.18,
                                content: missionModel.details,
                                images: vm.imgAttendantsList,
                              )
                            : loader(
                                _loadingComment(size.width, size.height * 0.18)),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 15, bottom: 15),
                        child: (!vm.isLoading)
                            ? CommentsCard(
                                haveAnyComment: vm.haveAnyComments,
                                comments: vm.commentList ?? "",
                                commentLength: vm.commentLength,
                                width: size.width * 0.8,
                                height: 170)
                            : loader(_loadingComment(size.width * 0.8, 170)),
                      )
                    ],
                  ))
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _loadingComment(double width, double height) {
    return Container(
        margin: EdgeInsets.all(15),
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(8)),
          boxShadow: [
            BoxShadow(color: Colors.black26, blurRadius: 5, spreadRadius: 0.5)
          ],
        ));
  }
}
