
import 'package:Eletor/api/action/user_api.dart';
import 'package:Eletor/api/base_model/base_model.dart';
import 'package:Eletor/models/user/response_register_model.dart';
import 'package:Eletor/models/user/user_info_account.dart';
import 'package:Eletor/utils/googles/authcredential_sign_in.dart';
import 'package:Eletor/utils/shared_preference.dart';
import 'package:Eletor/utils/values.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked/stacked.dart';

class SignInViewModel extends BaseViewModel {
  GoogleSignIn _googleSignIn;
  User _user;
  bool _loginStatus = false;
  bool _isPageLoading = false;

  bool get isPageLoading => _isPageLoading;
  bool _loadingLogin = false;

  bool _authenticated = false;

  final UserApi _userApi = UserApi();

  get isLogin => _loginStatus;

  get loadingLogin => _loadingLogin;

  get isAuthenticated => _authenticated;

  String _name = "";

  String _position = "";

  String _imageUrl;

  get name => _name;

  get position => _position;

  get imageUrl => _imageUrl;

  SignInViewModel() {
    init();
    _checkAuthentication();
  }

  init() async {
    try{
      await Firebase.initializeApp();
      _googleSignIn = GoogleSignIn();
      _user = FirebaseAuth.instance.currentUser;
      setCurrentUser();
      notifyListeners();
    }catch(error){
      print("Error init sign in view model: $error");
    }
  }

  setCurrentUser() {
    if (!(_user.isNull)) _loginStatus = true;
    notifyListeners();
  }

  signIn() async {
    try{
      GoogleSignInAccount account = await _googleSignIn.signIn();
      AuthenticationGoogleSignIn _auth = AuthenticationGoogleSignIn(account);
      await _auth.initializeAuth();
      _user = await _auth.userInfo;
      _signInSuccess(!(user.isNull));
      notifyListeners();
    }catch(error){
      print("Error sign in: $error");
    }
  }

  _signInSuccess(bool signInSuccess) {
    if (signInSuccess) {
      _loginStatus = true;
      notifyListeners();
    }
    notifyListeners();
  }

  saveSharePref(String value) async {
    try{
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString(Values.authenicized_key, value);
    }catch(error){
      print("Error save shared authentication key: $error");
    }
  }

  _checkAuthentication() async {
    try{
      SharedPreferences prefs = await SharedPreferenceUtils.initialize();
      if (prefs.getString(Values.authenicized_key) != null){
        _authenticated = true;
        notifyListeners();
      }
    }catch(error){
      print("Error check authentication: $error");
    }
  }

  saveUserInfo(String displayName ,String image)async{
    try{
      SharedPreferenceUtils.setString(Values.displayName, displayName);
      SharedPreferenceUtils.setString(Values.photoURL, image);
    }catch(error){
      print("Error save user info: $error");
    }
  }

  Future<bool> registerUser(UserInfo userInfo) async {
    try{
      UserInfoAccount infoAcc = UserInfoAccount(
          displayName: userInfo.displayName,
          email: userInfo.email,
          phoneNumber: userInfo.phoneNumber ?? 0,
          photoURL: userInfo.photoURL,
          uid: userInfo.uid);

      BaseModel<ResponseRegisterModel> response = await _userApi.register(infoAcc);

      if (response.data.status == 200) return true;
      return false;
    }catch(error){
      print("Error register user: $error");
    }
  }

  User get user => _user;
}
