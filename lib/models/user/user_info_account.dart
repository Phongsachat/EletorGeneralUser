/// displayName : "Ananyot jame"
/// email : "akananyotkeawlamoon2@gmail.com"
/// phoneNumber : null
/// photoURL : "https://lh3.googleusercontent.com/a-/AOh14GgjTYwZVfBoCFn29f7FMcp54foAhDBJDwxQ47YQig=s96-c"
/// uid : "107909652238484400421"

class UserInfoAccount {
  String _displayName;
  String _email;
  dynamic _phoneNumber;
  String _photoURL;
  String _uid;

  String get displayName => _displayName;
  String get email => _email;
  dynamic get phoneNumber => _phoneNumber;
  String get photoURL => _photoURL;
  String get uid => _uid;

  UserInfoAccount({
      String displayName, 
      String email, 
      dynamic phoneNumber, 
      String photoURL, 
      String uid}){
    _displayName = displayName;
    _email = email;
    _phoneNumber = phoneNumber;
    _photoURL = photoURL;
    _uid = uid;
}

  UserInfoAccount.fromJson(dynamic json) {
    _displayName = json["displayName"];
    _email = json["email"];
    _phoneNumber = json["phoneNumber"];
    _photoURL = json["photoURL"];
    _uid = json["uid"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["displayName"] = _displayName;
    map["email"] = _email;
    map["phoneNumber"] = _phoneNumber;
    map["photoURL"] = _photoURL;
    map["uid"] = _uid;
    return map;
  }

}