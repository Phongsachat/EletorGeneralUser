/// userId : ""

class UserIdModel {
  String _userId;

  String get userId => _userId;

  UserIdModel({
      String userId}){
    _userId = userId;
}

  UserIdModel.fromJson(dynamic json) {
    _userId = json["userId"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["userId"] = _userId;
    return map;
  }

}