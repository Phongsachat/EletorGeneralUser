// To parse this JSON data, do
//
//     final missionReportResponse = missionReportResponseFromJson(jsonString);

import 'dart:convert';

MissionReportResponse missionReportResponseFromJson(String str) => MissionReportResponse.fromJson(json.decode(str));

String missionReportResponseToJson(MissionReportResponse data) => json.encode(data.toJson());

class MissionReportResponse {
  MissionReportResponse({
    this.message,
    this.status,
    this.data,
  });

  String message;
  int status;
  Data data;

  factory MissionReportResponse.fromJson(Map<String, dynamic> json) => MissionReportResponse(
    message: json["message"] == null ? null : json["message"],
    status: json["status"] == null ? null : json["status"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "message": message == null ? null : message,
    "status": status == null ? null : status,
    "data": data == null ? null : data.toJson(),
  };
}

class Data {
  Data({
    this.isReported,
    this.injuredPersonNumber,
    this.assetsDamage,
    this.elephantBehavior,
    this.elephantNumber,
    this.solution,
    this.result,
  });

  bool isReported;
  int injuredPersonNumber;
  String assetsDamage;
  String elephantBehavior;
  int elephantNumber;
  String solution;
  String result;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    isReported: json["isReported"] == null ? null : json["isReported"],
    injuredPersonNumber: json["injuredPersonNumber"] == null ? null : json["injuredPersonNumber"],
    assetsDamage: json["assetsDamage"] == null ? null : json["assetsDamage"],
    elephantBehavior: json["elephantBehavior"] == null ? null : json["elephantBehavior"],
    elephantNumber: json["elephantNumber"] == null ? null : json["elephantNumber"],
    solution: json["solution"] == null ? null : json["solution"],
    result: json["result"] == null ? null : json["result"],
  );

  Map<String, dynamic> toJson() => {
    "isReported": isReported == null ? null : isReported,
    "injuredPersonNumber": injuredPersonNumber == null ? null : injuredPersonNumber,
    "assetsDamage": assetsDamage == null ? null : assetsDamage,
    "elephantBehavior": elephantBehavior == null ? null : elephantBehavior,
    "elephantNumber": elephantNumber == null ? null : elephantNumber,
    "solution": solution == null ? null : solution,
    "result": result == null ? null : result,
  };
}