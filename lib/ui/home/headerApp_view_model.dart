import 'package:Eletor/ui/home/home_view_model.dart';
import 'package:Eletor/utils/shared_preference.dart';
import 'package:Eletor/utils/values.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked/stacked.dart';

class HeaderAppViewModel extends BaseViewModel{


  bool _isLogOutSuccess = false;

  bool _isNotificationShow = false;

  set setNotificationShow(bool show) => _isNotificationShow = _isNotificationShow = show;

  get isNotificationShow => _isNotificationShow;

  get isLogOutSuccess => _isLogOutSuccess;

  GoogleSignIn _googleSignIn = GoogleSignIn();

  signOut(HomeViewModel vm) async {
    try{
      print("${vm.name} ${vm.position} ${vm.imageUrl} ");
      await signOutGoogle();
      SharedPreferences pref = await SharedPreferenceUtils.initialize();

      SharedPreferenceUtils.clearAll();
      if(!(pref.containsKey(Values.authenicized_key))){
        _isLogOutSuccess = true;
        _isNotificationShow = true;
        notifyListeners();
      }
    }catch(error){
      print("Error sign out: $error");
    }
  }
signOutGoogle() async {
  await _googleSignIn.signOut();
}
}