
/// elephantCharacterId : "E01"
/// elephantCharacterName : "name"
/// active : true

class ElephantCharacteristics {
  String elephantCharacterId;
  String elephantCharacterName;
  bool active;

  ElephantCharacteristics({
    this.elephantCharacterId,
    this.elephantCharacterName,
    this.active});

  ElephantCharacteristics.fromJson(dynamic json) {
    elephantCharacterId = json["elephantCharacterId"];
    elephantCharacterName = json["elephantCharacterName"];
    active = json["active"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["elephantCharacterId"] = elephantCharacterId;
    map["elephantCharacterName"] = elephantCharacterName;
    map["active"] = active;
    return map;
  }
}