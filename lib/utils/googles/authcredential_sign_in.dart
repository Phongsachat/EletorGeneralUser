import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthenticationGoogleSignIn {
  FirebaseAuth _auth;
  GoogleSignInAccount _account;
  User _userInfo;

  get userInfo => _userInfo;

  AuthenticationGoogleSignIn(this._account);

  Future<void> initializeAuth() async {
    this._auth = FirebaseAuth.instance;

    GoogleSignInAuthentication account = await _signInAuth(_account);
    AuthCredential authCredential = _authCredential(account);
    UserCredential userCredential = await _authResult(authCredential);

    _userInfo = userCredential.user;
  }

  Future<GoogleSignInAuthentication> _signInAuth(
      GoogleSignInAccount _account) async {
    return await _account.authentication;
  }

  AuthCredential _authCredential(GoogleSignInAuthentication _signInAuth) {
    return GoogleAuthProvider.credential(
        accessToken: _signInAuth.accessToken, idToken: _signInAuth.idToken);
  }

  Future<UserCredential> _authResult(AuthCredential _credential) async {
    return await _auth.signInWithCredential(_credential);
  }
}
