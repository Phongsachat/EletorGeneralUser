import 'dart:async';

import 'package:Eletor/utils/googles/firestore.dart';
import 'package:Eletor/utils/shared_preference.dart';
import 'package:Eletor/utils/values.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MissionCardsViewModel extends ChangeNotifier {

  int _commentLength = 0;
  Completer<GoogleMapController> _mapController = Completer();
  List<List<String>> _commentsList = List<List<String>>();

  List<String> _imgOfficerList = List<String>();

  bool _haveAnyComment = false;

  bool _isLoading = true;

  bool _isJoinMissionLoading = true;

  bool _isGetAttendantSuccess = false;

  String _missionID;

  FireStoreUtils _fireStoreComment, _fireStoreAttendants;

  List<Marker> _myMarker = [];

  get isLoading => _isLoading;

  get commentLength => _commentLength;

  get commentList => _commentsList;

  get getAttendantsSuccess => _isGetAttendantSuccess;

  List<String> get imgAttendantsList => _imgOfficerList;

  set setCommentLength(int length) => _commentLength = length;

  get haveAnyComments => _haveAnyComment;

  get missionID => _missionID;

  bool get isJoinMissionLoading => _isJoinMissionLoading;

  set initialize(String missionID) => init(missionID: missionID);

  List<Marker> get myMarker => _myMarker;
  Completer<GoogleMapController> get mapController => _mapController;
  MissionCardsViewModel();

  init({String missionID}) async {
    try {
      _fireStoreComment =
          FireStoreUtils("/comments/$missionID/MissionComments");
      _fireStoreAttendants = FireStoreUtils("/mission/$missionID/attendants");

      _imgOfficerList.clear();

      await getAttendants();
      await getComments();
      setMissionID(missionID);
    } catch (error) {
      print("Error init mission cards: $error");
    }
  }

  getComments() async {
    try{
      var lengthDocsOfCollect = await _fireStoreComment.createCollectionRef()
          .get()
          .then((value) => value.docs.length);

      if (lengthDocsOfCollect == 0) {
        _commentsList.clear();
        _isLoading = false;
        _haveAnyComment = false;
      } else {
        QuerySnapshot querySnapshot = await _fireStoreComment.orderByTimeStamp();
        var mapComments = querySnapshot.docs.map((doc) => doc.data());

        _commentLength = mapComments.length;

        if (mapComments.isNotEmpty) {
          _commentsList.clear();
          await pushComments(mapComments);
          _haveAnyComment = true;
          _isLoading = false;
        }
      }


      notifyListeners();
    }catch(error){
      print("Error get comments: $error");
    }
  }

  pushComments(var mapComments) async {

    try{
      /// comments in The CommendCard only have 2 comments
      int lengthComment = mapComments.length;

      /*** length of comment is can be 1 which require dynamic length
       * The CommentCard only need 2 comments list
       * */
      if (mapComments.length > 2) lengthComment = 2;

      /// A Loop for add comment data to _commentList variable
      for (int i = 0; i < lengthComment; i++) {

        /// Get name of user from FireStore which ['ref] ['displayName'] ['comment'] are Document Field
        String displayName = await mapComments.toList()[i]['ref'].get().then((
            doc) => doc.data()["displayName"]);
        String comment = mapComments.toList()[i]['comment'];

        /// Add comment and displayName
        _commentsList.add([displayName, comment]);
      }
    }catch(error){
      print("Error push comment: $error");
    }
  }

  setMissionID(String missionID) {
    _missionID = missionID;
    notifyListeners();
  }

  getAttendants() async {
    try {
      await _fireStoreAttendants.createCollectionRef().get().then((collect) {
        collect.docs.forEach((element) async {
          if (element.data()['isAccept']) {
            DocumentSnapshot docsSnapShot = await element['uid'].get();
            if (docsSnapShot.exists) {

              /// Do not duplicate an image
              int index = _imgOfficerList.indexWhere((element) => element == docsSnapShot.data()['photoURL']);

              if(index==-1){
                _imgOfficerList.add(docsSnapShot.data()['photoURL']);
              }
            }
          }
        });

      });
      notifyListeners();
    } catch (error) {
      print("Error get attendants: $error");
    }
  }
}
