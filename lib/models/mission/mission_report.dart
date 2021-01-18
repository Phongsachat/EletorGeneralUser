// To parse this JSON data, do
//
//     final missionReport = missionReportFromJson(jsonString);

import 'dart:convert';

MissionReport missionReportFromJson(String str) => MissionReport.fromJson(json.decode(str));

String missionReportToJson(MissionReport data) => json.encode(data.toJson());

class MissionReport {
  MissionReport({
    this.missionId,
    this.userId,
    this.injuredPersonNumber,
    this.assetsDamage,
    this.elephantBehavior,
    this.elephantNumber,
    this.solution,
    this.result,
  });

  String missionId;
  String userId;
  int injuredPersonNumber;
  String assetsDamage;
  String elephantBehavior;
  int elephantNumber;
  String solution;
  String result;

  factory MissionReport.fromJson(Map<String, dynamic> json) => MissionReport(
    missionId: json["missionId"] == null ? null : json["missionId"],
    userId: json["userId"] == null ? null : json["userId"],
    injuredPersonNumber: json["injuredPersonNumber"] == null ? null : json["injuredPersonNumber"],
    assetsDamage: json["assetsDamage"] == null ? null : json["assetsDamage"],
    elephantBehavior: json["elephantBehavior"] == null ? null : json["elephantBehavior"],
    elephantNumber: json["elephantNumber"] == null ? null : json["elephantNumber"],
    solution: json["solution"] == null ? null : json["solution"],
    result: json["result"] == null ? null : json["result"],
  );

  Map<String, dynamic> toJson() => {
    "missionId": missionId == null ? null : missionId,
    "userId": userId == null ? null : userId,
    "injuredPersonNumber": injuredPersonNumber == null ? null : injuredPersonNumber,
    "assetsDamage": assetsDamage == null ? null : assetsDamage,
    "elephantBehavior": elephantBehavior == null ? null : elephantBehavior,
    "elephantNumber": elephantNumber == null ? null : elephantNumber,
    "solution": solution == null ? null : solution,
    "result": result == null ? null : result,
  };
}