import 'package:Eletor/api/action/user_api.dart';
import 'package:Eletor/api/base_model/base_model.dart';
import 'package:Eletor/models/user/user_id_model.dart';
import 'package:Eletor/models/user/user_info_model.dart';
import 'package:Eletor/utils/googles/firestore.dart';
import 'package:Eletor/utils/shared_preference.dart';
import 'package:Eletor/utils/values.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:stacked/stacked.dart';

class HomeViewModel extends BaseViewModel {
  bool _homeState = true;

  bool _isJoinMission = false;

  UserApi _userApi = UserApi();

  get homeState => _homeState;

  get isJoinMission => _isJoinMission;

  String _name = "";

  String _position = "";

  String _imageUrl;

  get name => _name;

  get position => _position;

  get imageUrl => _imageUrl;

  FireStoreUtils _fireStoreAttendants;

  HomeViewModel() {
    init();
  }

  init() async {
    try{
      String authKey = SharedPreferenceUtils.getString(Values.authenicized_key);
      UserIdModel userIdModel = UserIdModel(userId: authKey);
      // await getUserInformation(userIdModel);
    }catch(error){
      print("Error Init home view model $error");
    }
  }

  changeHomeState(bool homeState) {
    _homeState = homeState;
    notifyListeners();
  }

  saveUserInfo(String displayName, String image) async {
    try{
      SharedPreferenceUtils.setString(Values.displayName, displayName);
      SharedPreferenceUtils.setString(Values.photoURL, image);
    }catch(error){
      print("Error save user info: $error");
    }
  }

  checkingWasJoinMission(String missionId) async {
    try{
      _fireStoreAttendants = FireStoreUtils("/mission/$missionId/attendants");
      CollectionReference collAttendantsRef =
      _fireStoreAttendants.createCollectionRef();

      String uid = SharedPreferenceUtils.getString(Values.authenicized_key);
      DocumentSnapshot docRef = await collAttendantsRef.doc(uid).get();

      if (docRef.exists)
        _isJoinMission = true;
      else
        _isJoinMission = false;
      notifyListeners();
    }catch(error){
      print("Error checked join mission: $error");
    }
  }
}
