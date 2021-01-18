import 'package:cloud_firestore/cloud_firestore.dart';

class MissionModel {
  String _locationName, _situationTime, _details, _photoURL, _missionId, _finishTime, _missionReportId;

  int _severityId,_missionStatus;

  GeoPoint _latLng;

  bool _missionReportStatus;


  get missionStatus => _missionStatus;

  set setMissionStatus(value) {
    _missionStatus = value;
  }


  MissionModel(
      this._locationName,
      this._situationTime,
      this._details,
      this._photoURL,
      this._severityId,
      this._latLng,
      this._missionId,
      this._missionStatus,
      this._finishTime,
      this._missionReportId,
      this._missionReportStatus);

  GeoPoint get latLng => _latLng;

  set setLatLng(GeoPoint value) {
    _latLng = value;
  }

  String get missionId => _missionId;

  set setMissionId(String value) {
    _missionId = value;
  }

  get situationTime => _situationTime;

  set setSituationTime(value) {
    _situationTime = value;
  }

  int get severityId => _severityId;

  set setSeverityId(int value) {
    _severityId = value;
  }

  String get locationName => _locationName;

  set setLocationName(String value) {
    this._locationName = value;
  }

  get details => _details;

  set setDetails(value) {
    _details = value;
  }

  get photoURL => _photoURL;

  set setPhotoURL(value) {
    _photoURL = value;
  }

  get finishTimStamp => _finishTime;

  set setFinishTimStamp(value) {
    _finishTime = value;
  }

  bool get missionReportStatus => _missionReportStatus;

  set setMissionReportStatus(bool value) {
    _missionReportStatus = value;
  }

  get missionReportId => _missionReportId;

  set setMissionReportId(value) {
    _missionReportId = value;
  }
}