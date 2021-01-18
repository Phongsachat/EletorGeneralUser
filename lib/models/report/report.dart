
import 'package:Eletor/models/report/elephantCharacteristics.dart';

/// reportId : 1
/// missionId : "dsf"
/// locationGroupId : "dsf"
/// accountId : "dsf"
/// timeStamp : 1
/// elephantAmount : 2
/// reportDetails : "dsf"
/// reportStatus : 2
/// image : "dsf"
/// locationName : "dsf"
/// userLatLng : ""
/// pinLatLng : 2
/// elephantCharacterList : [{"elephantCharacterId":"E01","elephantCharacterName":"name","active":true},{"elephantCharacterId":"E02","elephantCharacterName":"name","active":true}]

class Report {
  String reportId;
  String missionId;
  String locationGroupId;
  String accountId;
  int timeStamp;
  int elephantAmount;
  String reportDetails;
  int reportStatus;
  String image;
  String locationName;
  double userLat;
  double userLng;
  double pinLat;
  double pinLng;
  List<ElephantCharacteristics> elephantCharacteristicsList;

  Report({
    this.reportId,
    this.missionId,
    this.locationGroupId,
    this.accountId,
    this.timeStamp,
    this.elephantAmount,
    this.reportDetails,
    this.reportStatus,
    this.image,
    this.locationName,
    this.userLat,
    this.userLng,
    this.pinLat,
    this.pinLng,
    this.elephantCharacteristicsList});

  Report.fromJson(dynamic json) {
    reportId = json["reportId"];
    missionId = json["missionId"];
    locationGroupId = json["locationGroupId"];
    accountId = json["accountId"];
    timeStamp = json["timeStamp"];
    elephantAmount = json["elephantAmount"];
    reportDetails = json["reportDetails"];
    reportStatus = json["reportStatus"];
    image = json["image"];
    locationName = json["locationName"];
    userLat= json["userLat"];
    userLng= json["userLng"];
    pinLat= json["pinLat"];
    pinLng= json["pinLng"];
    if (json["elephantCharacterList"] != null) {
      elephantCharacteristicsList = [];
      json["elephantCharacterList"].forEach((v) {
        elephantCharacteristicsList.add(ElephantCharacteristics.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["reportId"] = reportId;
    map["missionId"] = missionId;
    map["locationGroupId"] = locationGroupId;
    map["accountId"] = accountId;
    map["timeStamp"] = timeStamp;
    map["elephantAmount"] = elephantAmount;
    map["reportDetails"] = reportDetails;
    map["reportStatus"] = reportStatus;
    map["image"] = image;
    map["locationName"] = locationName;
    map["userLat"] = userLat;
    map["userLng"] = userLng;
    map["pinLat"] = pinLat;
    map["pinLng"] = pinLng;
    if (elephantCharacteristicsList != null) {
      map["elephantCharacterList"] = elephantCharacteristicsList.map((v) => v.toJson()).toList();
    }
    return map;
  }

}


