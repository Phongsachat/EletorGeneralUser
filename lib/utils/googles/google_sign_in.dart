import 'package:Eletor/utils/googles/authcredential_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Google {
  GoogleSignIn _googleSignIn;
  User _userSignIn;
  bool _userSignOut;

  get userSignIn => _userSignIn;

  get userSignOut => _userSignOut;

  Google(){
    initialize();
  }


  initialize() async {
    await Firebase.initializeApp();
    this._googleSignIn = GoogleSignIn();
  }

  Future<User> signIn() async {
    GoogleSignInAccount account = await _account(_googleSignIn);
    AuthenticationGoogleSignIn _auth = AuthenticationGoogleSignIn(account);
    await _auth.initializeAuth();

    return _auth.userInfo;
  }

  Future<void> signOut() async {
    await _googleSignIn.signOut();
    _userSignOut = true;
  }

  bool isCurrentUser() => (FirebaseAuth.instance.currentUser != null) ? true : false;


  Future<GoogleSignInAccount> _account(GoogleSignIn googleSignIn) async {
    return await googleSignIn.signIn();
  }
}
