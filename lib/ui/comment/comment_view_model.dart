import 'package:Eletor/utils/googles/firestore.dart';
import 'package:Eletor/utils/string_values.dart';
import 'package:Eletor/utils/values.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked/stacked.dart';

class CommentViewModel extends BaseViewModel {
  int _commentLength = 0;

  get getCommentLength => _commentLength;

  List<String> _listUsername = List<String>();

  get getListUserName => _listUsername;

  List<String> _userPhotoUrl = List<String>();

  get getUserPhotoUrl => _userPhotoUrl;

  List<String> _commentList = List<String>();

  get getCommentList => _commentList;

  int _loadingCounter = 0;

  static String _photoURL;

  static String _displayName;

  static String _userId;

  String _missionID;

  bool _haveAnyComment = false;

  FireStoreUtils _fireStoreUtils;

  get getLoaderCounter => _loadingCounter;

  set setLoaderCounter(int count) => _loadingCounter = _loadingCounter + count;

  get haveAnyComment => _haveAnyComment;

  get getUserId => _userId;

  get displayName => _displayName;

  get photoURL => _photoURL;

  set initialize(String missionID) => init(missionID: missionID);

  FireStoreUtils get fireStore => _fireStoreUtils;

  CommentViewModel();

  init({String missionID}) async {
   try{
     _fireStoreUtils = FireStoreUtils("/comments/$missionID/MissionComments");
     getComments();
     await getPhotoURL();
     _missionID = missionID;
   }catch(error){
     print("Error init comment view model: $error");
   }
  }

  getComments() async {
    try{
      QuerySnapshot querySnapshot = await _fireStoreUtils.orderByTimeStamp();

      var mapDocsComment = querySnapshot.docs.map((doc) => doc.data());

      if (mapDocsComment.isNotEmpty) {
        _haveAnyComment = true;
        _commentLength = mapDocsComment.length;
        notifyListeners();
      }
    }catch(error,stacker){
      print("Error Get comments: $error");
    }
  }

  getPhotoURL() async {
    try{
      SharedPreferences pref = await SharedPreferences.getInstance();
      _photoURL = pref.getString(Values.photoURL ?? StringValue.http_unknown);
      _displayName = pref.getString(Values.displayName ?? StringValue.unknown);
      _userId = pref.getString(Values.authenicized_key);
    }catch(error){
      print("Error Get PhotoURL $error");
    }
  }

  bool confirmComment(String comment) {
    try {
      CollectionReference commentsRef = FirebaseFirestore.instance
          .collection("/comments/$_missionID/MissionComments");
      DocumentReference ref = FirebaseFirestore.instance.doc("/users/$_userId");

      commentsRef.add({
        "comment": comment,
        "ref": ref,
        "timeStamp": Timestamp.now(),
      });

      return true;
    } catch (error) {
      print("Error confirm comment $error");
      return false;
    }
  }

  setMissionID(String id) {
    _missionID = id;
    print(_missionID);
  }

  @override
  void dispose() {
    _loadingCounter = 0;
    super.dispose();
    notifyListeners();
  }
}
