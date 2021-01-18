import 'package:Eletor/utils/googles/firestore.dart';
import 'package:Eletor/utils/shared_preference.dart';
import 'package:Eletor/utils/values.dart';
import 'package:Eletor/widgets/tile_list/report_list.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:stacked/stacked.dart';

import 'history_title.dart';
import 'history_view_model.dart';

class HistoryView extends StatelessWidget {

  FireStoreUtils _fireStoreUtils = FireStoreUtils("/reports");
  int length;
  String accountId = SharedPreferenceUtils.getString(Values.authenicized_key);
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
        viewModelBuilder: () => HistoryViewModel(),
        builder: (context, vm, child) {
          return Column(
            children: [
              Container(
                child: HistoryTitle(),
              ),
              Expanded(
                  child: SizedBox(
                    child: StreamBuilder<QuerySnapshot>(
                        stream: _fireStoreUtils.reportHistorySnapShot(accountId),
                        builder: (BuildContext context,
                            AsyncSnapshot<QuerySnapshot> snapshot) {
                          return ListView.builder(
                            scrollDirection: Axis.vertical,
                            itemCount: (snapshot.data!=null)? snapshot.data.docs.length : 0,
                            itemBuilder: (context, index) {

                              var chunkReport = snapshot.data.docs[index].data();
                              // String accountId = chunkReport['accountId'];
                              // int elephantAmount = chunkReport['elephantAmount'];
                              // String imgSrc = chunkReport['imgSrc'];
                              // String locationGroupId = chunkReport['locationGroupId'];
                              String locationName = chunkReport['locationName'];
                              // String missionId = chunkReport['missionId'];
                              // GeoPoint pinLatLng = chunkReport['pinLatLng'];
                              // String reportDetails = chunkReport['reportDetails'];
                              // int reportId = chunkReport['reportId'];
                              int reportStatus = chunkReport['reportStatus'];
                              Timestamp timeStamp = chunkReport['timeStamp'];
                              // GeoPoint userLatLng = chunkReport['userLatLng'];
                              // Timestamp userTimeStamp = chunkReport['userTimeStamp'];



                              return AnimationConfiguration.staggeredList(
                                position: index,
                                duration: const Duration(milliseconds: 200),
                                child: SlideAnimation(
                                  verticalOffset: 50.0,
                                  child: FadeInAnimation(
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          bottom: 8.0, left: 15.0, right: 15.0),
                                      child: ReportTile(
                                        locationName: locationName,
                                        reportStatus: reportStatus,
                                          timeStamp: timeStamp
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          );
                        }
                    ),
                  ))
            ],
          );
        });
  }
}
