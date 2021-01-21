import 'package:Eletor/utils/values.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked/stacked.dart';

class SplashScreenViewModel extends BaseViewModel {
  User _user;

  bool _loadingLogin = false;

  bool _authenticated = false;

  get isAuthenticated => _authenticated;

  get loadingLogin => _loadingLogin;

  SplashScreenViewModel() {
    init();
  }

  init() async {
    notifyListeners();
  }


  checkAuthentication() async {
    try{
      SharedPreferences prefs = await SharedPreferences.getInstance();

      if(prefs.containsKey(Values.authenicized_key)){
        if (prefs.getString(Values.authenicized_key).isNotEmpty){
          _authenticated = true;
          notifyListeners();
        }
      }
    }catch(error){
      print("Error check authentication: $error");
    }
  }

  User get user => _user;
}
