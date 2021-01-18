class UserInfoModel {
  String _message;
  int _status;
  Data _data;

  String get message => _message;

  int get status => _status;

  Data get data => _data;

  UserInfoModel({String message, int status, Data data}) {
    _message = message;
    _status = status;
    _data = data;
  }

  UserInfoModel.fromJson(dynamic json) {
    _message = json["message"];
    _status = json["status"];
    _data = json["data"] != null ? Data.fromJson(json["data"]) : null;
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["message"] = _message;
    map["status"] = _status;
    if (_data != null) {
      map["data"] = _data.toJson();
    }
    return map;
  }
}

class Data {
  String _displayName;
  String _photoURL;

  String get displayName => _displayName;

  String get photoURL => _photoURL;

  Data({String displayName, String photoURL}) {
    _displayName = displayName;
    _photoURL = photoURL;
  }

  Data.fromJson(dynamic json) {
    _displayName = json["displayName"];
    _photoURL = json["photoURL"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["displayName"] = _displayName;
    map["photoURL"] = _photoURL;
    return map;
  }
}
