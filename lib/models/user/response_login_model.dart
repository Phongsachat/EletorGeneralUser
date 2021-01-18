class ResponseLoginModel {
  String _message;
  int _status;
  Data _data;

  String get message => _message;
  int get status => _status;
  Data get data => _data;

  ResponseLoginModel({
      String message, 
      int status, 
      Data data}){
    _message = message;
    _status = status;
    _data = data;
}

  ResponseLoginModel.fromJson(dynamic json) {
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
  String _authenticized;

  String get authenticized => _authenticized;

  Data({
      String authenticized}){
    _authenticized = authenticized;
}

  Data.fromJson(dynamic json) {
    _authenticized = json["authenticized"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["authenticized"] = _authenticized;
    return map;
  }

}