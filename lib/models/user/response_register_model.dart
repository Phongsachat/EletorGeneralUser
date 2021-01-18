class ResponseRegisterModel {
  String _message;
  int _status;
  Data _data;

  String get message => _message;
  int get status => _status;
  Data get data => _data;

  ResponseRegisterModel({
      String message, 
      int status, 
      Data data}){
    _message = message;
    _status = status;
    _data = data;
}

  ResponseRegisterModel.fromJson(dynamic json) {
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
  String _success;

  String get success => _success;

  Data({
      String success}){
    _success = success;
}

  Data.fromJson(dynamic json) {
    _success = json["success"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["success"] = _success;
    return map;
  }

}