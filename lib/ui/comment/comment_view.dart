import 'dart:core';

import 'package:Eletor/ui/comment/comment_view_model.dart';
import 'package:Eletor/ui/missioncards/mission_cards_view_model.dart';
import 'package:Eletor/utils/googles/firestore.dart';
import 'package:Eletor/utils/string_values.dart';
import 'package:Eletor/widgets/commands/comment_component.dart';
import 'package:Eletor/widgets/commands/writing_comments.dart';
import 'package:Eletor/widgets/constants.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';

class CommentView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _CommentView();
}

class _CommentView extends State<CommentView> {
  final List<String> imagesList = [
    "https://img.freepik.com/free-photo/mand-holding-cup_1258-340.jpg?size=626&ext=jpg",
    "https://cdn.now.howstuffworks.com/media-content/0b7f4e9b-f59c-4024-9f06-b3dc12850ab7-1920-1080.jpg",
    "https://img.freepik.com/free-photo/mand-holding-cup_1258-340.jpg?size=626&ext=jpg",
    "https://cdn.now.howstuffworks.com/media-content/0b7f4e9b-f59c-4024-9f06-b3dc12850ab7-1920-1080.jpg",
    "https://img.freepik.com/free-photo/mand-holding-cup_1258-340.jpg?size=626&ext=jpg",
    "https://cdn.now.howstuffworks.com/media-content/0b7f4e9b-f59c-4024-9f06-b3dc12850ab7-1920-1080.jpg",
    "https://img.freepik.com/free-photo/mand-holding-cup_1258-340.jpg?size=626&ext=jpg",
  ];

  final List<String> account = [
    "สุรนารี มหาวิทยาลัย",
    "Suranaree University",
    "นครราชสีมา โคราช",
    "ประทาย ดินแดนสวยงาม",
    "วัยรุ่น เมกา",
    "นักท่องเที่ยว ส่องช้าง",
  ];

  final List<String> comments = [
    "ช้างออช้างออกมาจ้าช้างออกมาจ้าช้างออกมาจ้าช้างออกมาจ้าช้างออกมาจ้าช้างออกมาจ้ากมาจ้า",
    "ช้างช้างออกมาจ้าช้างออกมาจ้าช้างออกมาจ้าช้างออกมาจ้าออกมาจ้า",
    "ช้างออกมช้างออกมาจ้าช้างออกมาจ้าช้างออกมาจ้าช้างออกมาจ้าช้างออกมาจ้าช้างออกมาจ้าช้างออกมาจ้าช้างออกมาจ้าช้างออกมาจ้าาจ้า",
    "ช้างออกมช้างออกมาจ้าช้างออกมาจ้าช้างออกมาจ้าช้างออกมาจ้าาจ้า",
    "ช้างออกช้างออกมาจ้าช้างออกมาจ้าช้างออกมาจ้าช้างออกมาจ้าช้างออกมาจ้าช้างออกมาจ้ามาจ้า",
    "ช้างออกช้างออกมาจ้าช้างออกมาจ้าช้างออกมาจ้าช้างออกมาจ้าช้างออกมาจ้าช้างออกมาจ้ามาจ้า"
  ];

  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Consumer2<CommentViewModel,MissionCardsViewModel>(
      builder: (context, vm1, vm2,child) {

        FireStoreUtils fireStoreUtils = FireStoreUtils("/comments/${vm2.missionID}/MissionComments");
      //  vm1.setMissionID(vm2.missionID);
        vm1.initialize = vm2.missionID;


        return WillPopScope(
          onWillPop: () async{

            vm2.init(missionID: vm2.missionID);
            return true;
          },
          child: StreamBuilder<QuerySnapshot>(
            stream: fireStoreUtils.orderByTimeStampSnapShot(),
            builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {}

              if (snapshot.connectionState == ConnectionState.waiting) {
                // vm1.setLoaderCounter = 1;
                //
                // if (vm1.getLoaderCounter == 1 || snapshot.data == null){
                //   EasyLoading.show();
                //
                // }

                if(!vm1.haveAnyComment) EasyLoading.dismiss();
              }


              return Scaffold(
                  appBar: AppBar(
                    title: AutoSizeText(StringValue.comment, style: TextStyle(fontFamily: primaryFontFamily),),
                    backgroundColor: primaryColor,
                  ),
                  body: GestureDetector(
                    onTap: () async {
                      FocusScope.of(context).requestFocus(FocusNode());
                    },
                    child: Column(
                      children: [
                        Expanded(
                            flex: 8,
                            child: ListView.builder(
                                itemCount: (snapshot.data == null) ? vm1.getCommentLength : snapshot.data.docs.length,
                                itemBuilder: (context, index) {

                                  if(snapshot.data!=null){

                                    DocumentSnapshot queryDocsSnap = snapshot.data.docs[index];
                                    DocumentReference docsRefUserInfo = queryDocsSnap['ref'];
                                    vm2.setCommentLength = snapshot.data.docs.length;

                                    return StreamBuilder(
                                        stream: docsRefUserInfo.snapshots(),
                                        builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot>docSnapShot) {

                                          if (docSnapShot.data == null) {
                                            return Container();
                                          }

                                          EasyLoading.dismiss();

                                          return CommentComponent(
                                              imageUrl: docSnapShot.data.data()['photoURL'],
                                              account: docSnapShot.data.data()['displayName'],
                                              comment: queryDocsSnap['comment']);
                                        });
                                  }

                                  return Container();
                                })),
                        Container(
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.grey[200],
                                      spreadRadius: 5,
                                      blurRadius: 5)
                                ]),
                            child: (vm1.photoURL != null)
                                ? StateWritingComment(
                                    controller: controller,
                                    onTap: () {
                                      FocusScope.of(context).requestFocus(FocusNode());

                                      String comment = controller.text.toString();
                                      controller.clear();

                                      if (comment.trim().isNotEmpty) {
                                        vm1.confirmComment(comment);
                                      }
                                    },
                                    imageUrl: vm1.photoURL,
                                  )
                                : Container(),
                          ),
                        ),
                      ],
                    ),
                  ));
            },
          ),
        );
      },
    );
  }
}
