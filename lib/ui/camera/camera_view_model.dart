import 'dart:async';
import 'dart:collection';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:io' as Io;

import 'package:Eletor/api/action/report_api.dart';
import 'package:Eletor/api/base_model/base_model.dart';
import 'package:Eletor/models/report/elephantCharacteristics.dart';
import 'package:Eletor/models/report/report.dart';
import 'package:Eletor/utils/string_values.dart';
import 'package:Eletor/utils/values.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_map_location_picker/google_map_location_picker.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked/stacked.dart';

class CameraViewModel extends BaseViewModel {
  ///camera_view
  File _imagesFile;
  ImagePicker _picker = ImagePicker();

  ///camera_send_mission
  Completer<GoogleMapController> _controllerCompleter = Completer();
  Set<Marker> markers = HashSet<Marker>();
  GoogleMapController mapController;
  double _lat;
  double _lng;
  double _userLat;
  double _userLng;
  LatLng _latLng;
  bool _loading = true;
  LocationResult _pickedLocation;
  List<Marker> _myMarker = [];
  int _check;
  String _apiKey = 'AIzaSyCyThvaSaUxmZGCpKv-T4jfz6SL__hdCtU';
  TextEditingController _textNote = TextEditingController();
  TextEditingController _textElephantAmount = TextEditingController(text: '1');
  TextEditingController _textLocationName = TextEditingController();
  String _hour, _minute, _time;
  String _dateTime;
  DateTime _selectedDate;
  static TimeOfDay _selectedTime = TimeOfDay(hour: 00, minute: 00);
  TextEditingController _dateController = TextEditingController();
  TextEditingController _timeController = TextEditingController();
  List<bool> _isSelected = [false, false, false, false];
  int _maxLengthValue;
  String _showNameLocation;
  bool _valueCheck = false;
  int _timeStampValue;
  List<Placemark> _placemarks;
  int _favoriteLocationValue = 1;
  List<LatLng> _favoriteLocationLatLng = [
    LatLng(14.557059962689536, 101.40119691280485),
    LatLng(14.53317426889962, 101.36911111070357),
    LatLng(14.528712016072662, 101.36946594280283),
    LatLng(14.535288819093966, 101.3848664781)
  ];

  //ElephantCharacteristics List
  List<String> elpCharacterList = ["eat", "onRoad", "angry", "destroy"];

  ///Global Valuable
  bool get loading => _loading;

  double get lat => _lat;

  double get lng => _lng;

  File get imagesFile => _imagesFile;

  int get check => _check;

  List<Marker> get myMarker => _myMarker;

  TextEditingController get textNote => _textNote;

  TextEditingController get textElephantAmount => _textElephantAmount;

  TextEditingController get textLocationName => _textLocationName;

  TimeOfDay get selectedTime => _selectedTime;

  DateTime get selectedDate => _selectedDate;

  TextEditingController get timeController => _timeController;

  TextEditingController get dateController => _dateController;

  String get showNameLocation => _showNameLocation;

  bool get valueCheck => _valueCheck;

  int get favoriteLocationValue => _favoriteLocationValue;

  String get dateTime => _dateTime;

  List<bool> get isSelected => _isSelected;

  Completer<GoogleMapController> get controllerCompleter =>
      _controllerCompleter;

  CameraViewModel() {
    initState();
    notifyListeners();
  }

  initState() async {
    //_selectedTime = null;
    await location();
    localDateTime();
    //timeStamp();
    notifyListeners();
  }

  openGallery(BuildContext context) async {
    try {
      var pickedFile = await _picker.getImage(source: ImageSource.gallery);
      _imagesFile = File(pickedFile.path);
      Navigator.of(context).pop();
      notifyListeners();
    } catch (error) {
      print("Error open gallery: $error");
    }
  }

  openCamera(BuildContext context) async {
    try {
      var pickedFile = await _picker.getImage(source: ImageSource.camera);
      _imagesFile = File(pickedFile.path);
      Navigator.of(context).pop();
      notifyListeners();
    } catch (error) {
      print("Error open camera: $error");
    }
  }

  location() async {
    try {
      var position = await GeolocatorPlatform.instance
          .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

      ///Global LatLng
      _lat = position.latitude;
      _lng = position.longitude;

      ///User LatLng
      _userLat = position.latitude;
      _userLng = position.longitude;
      _latLng = LatLng(position.latitude, position.longitude);
      loadingValue();
      await locationName();
      goToMe();
      print("location() working");
      notifyListeners();
    } catch (error) {
      print("Error location $error");
    }
  }

  loadingValue() {
    _loading = false;
    notifyListeners();
  }

  locationName() async {
    try {
      _placemarks = await placemarkFromCoordinates(_lat, _lng);
      if (_placemarks[0].street != '') {
        textLocationName.text = _placemarks[0].street;
      } else if (_placemarks[0].street == '' &&
          _placemarks[0].subLocality != '') {
        textLocationName.text = _placemarks[0].subLocality.toString();
      } else if (_placemarks[0].street == '' &&
          _placemarks[0].subLocality == '' &&
          _placemarks[0].locality != '') {
        textLocationName.text = _placemarks[0].locality.toString();
      } else if (_placemarks[0].street == '' &&
          _placemarks[0].subLocality == '' &&
          _placemarks[0].locality == '' &&
          _placemarks[0].subAdministrativeArea != '') {
        textLocationName.text = _placemarks[0].subAdministrativeArea;
      } else if (_placemarks[0].street == '' &&
          _placemarks[0].subLocality == '' &&
          _placemarks[0].locality == '' &&
          _placemarks[0].subAdministrativeArea == '' &&
          _placemarks[0].country != '') {
        textLocationName.text = _placemarks[0].country;
      } else {
        textLocationName.text = 'Unknown';
      }

      maxLength(_textLocationName);
      // await textLocationNameValue(_placemarks[0].street.toString());
      // print('${_placemarks[0]}');
      // print("locationName :" + _placemarks[0].street.toString());
      notifyListeners();
    } catch (error) {
      print("Error location name: $error");
    }
  }

  textLocationNameValue(String placemarks) {
    textLocationName.text = placemarks;
    notifyListeners();
  }

  favoriteLocation(value, context) async {
    try {
      _favoriteLocationValue = value;
      String locationNameChanged = '';
      switch (_favoriteLocationValue) {
        case 1:
          {
            location();
            maxLength(_textLocationName);
          }
          break;
        case 2:
          {
            _textLocationName.text = StringValue.favoriteLocationValue1;
            locationNameChanged = StringValue.favoriteLocationValue1;
            _lat = _favoriteLocationLatLng[0].latitude;
            _lng = _favoriteLocationLatLng[0].longitude;
            maxLength(_textLocationName);
          }
          break;
        case 3:
          {
            _textLocationName.text = StringValue.favoriteLocationValue2;
            locationNameChanged = StringValue.favoriteLocationValue2;
            _lat = _favoriteLocationLatLng[1].latitude;
            _lng = _favoriteLocationLatLng[1].longitude;
            maxLength(_textLocationName);
          }
          break;
        case 4:
          {
            _textLocationName.text = StringValue.favoriteLocationValue3;
            locationNameChanged = StringValue.favoriteLocationValue3;
            _lat = _favoriteLocationLatLng[2].latitude;
            _lng = _favoriteLocationLatLng[2].longitude;
            maxLength(_textLocationName);
          }
          break;
        case 5:
          {
            _textLocationName.text = StringValue.favoriteLocationValue4;
            locationNameChanged = StringValue.favoriteLocationValue4;
            _lat = _favoriteLocationLatLng[3].latitude;
            _lng = _favoriteLocationLatLng[3].longitude;
            maxLength(_textLocationName);
          }
          break;
        default:
          {
            print("favorite Location = 6");
          }
          break;
      }
      await changedLocationByDropDown();
      _showNameLocation = locationNameChanged;
      notifyListeners();
    } catch (error) {
      print("Error favorite Location: $error");
    }
  }

  changedLocationByDropDown() async {
    try {
      _myMarker = [];
      _myMarker.add(Marker(
          markerId: MarkerId('0'),
          position: LatLng(_lat, _lng),
          draggable: true,
          onDragEnd: (dragEndPosition) {
            print(dragEndPosition);
          }));
      GoogleMapController controller = await _controllerCompleter.future;
      controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target: LatLng(_lat, _lng),
        zoom: 16,
      )));
      notifyListeners();
    } catch (error) {
      print("Error go to me: $error");
    }
  }

  pickLocation(context, location) async {
    try {
      LocationResult result = await showLocationPicker(
        context,
        _apiKey,
        initialCenter: LatLng(_lat, _lng),
        myLocationButtonEnabled: true,
        layersButtonEnabled: true,
        language: 'th',
        initialZoom: 18,
        countries: ['TH'],
        desiredAccuracy: LocationAccuracy.bestForNavigation,
        automaticallyAnimateToCurrentLocation: false,
      );

      _pickedLocation = result;
      _latLng = _pickedLocation.latLng;
      _lat = _latLng.latitude;
      _lng = _latLng.longitude;
      goToMe();
      int _flValue = 6;
      favoriteLocation(_flValue, context);
      notifyListeners();
    } catch (error) {
      print("Error pick location: $error");
    }
  }

  localDateTime() {
    try {
      _selectedDate = DateTime.now();
      _dateTime = DateFormat('dd MMM yyyy').format(_selectedDate);

      _selectedTime = TimeOfDay.now();
      _hour = _selectedTime.hour.toString();
      _minute = _selectedTime.minute.toString();
      _time = _hour + ' : ' + _minute;
      _timeController.text = _time;
      _timeController.text = formatDate(
          DateTime(_selectedDate.year, _selectedDate.month, _selectedDate.day,
              _selectedTime.hour, _selectedTime.minute),
          [HH, ':', nn]).toString();

      _dateController.text = _dateTime;

      notifyListeners();
    } catch (error) {
      print("Error local date time: $error");
    }
  }

  timeStamp() {
    try {
      var sec = (new DateTime.now());
      final dateStr =
          "${_selectedDate.year}-${_selectedDate.month}-${_selectedDate.day} ${_selectedTime.hour}:${_selectedTime.minute}:${sec.second} UTC+7";
      final formatter = DateFormat(r'''yyyy-mm-dd hh:mm:ss Z''');

      final dateTimeFromStr = formatter.parse(dateStr);
      _timeStampValue = dateTimeFromStr.toUtc().millisecondsSinceEpoch;
    } catch (error) {
      print("Error timestamp $error");
    }
  }

  maxLength(_textLocationName) {
    try {
      if (textLocationName.text.toString().length > 20) {
        _maxLengthValue = 20;
        _showNameLocation = textLocationName.text.replaceRange(
            _maxLengthValue, textLocationName.text.toString().length, '...');
      } else {
        _maxLengthValue = textLocationName.text.toString().length;
        _showNameLocation = textLocationName.text;
      }
      notifyListeners();
    } catch (error) {
      print("Error max length: $error");
    }
  }

  isSelectedValue(int index) {
    try {
      for (int buttonIndex = 0;
          buttonIndex < _isSelected.length;
          buttonIndex++) {
        if (buttonIndex == index) {
          _isSelected[buttonIndex] = !_isSelected[buttonIndex];
        }
      }
      notifyListeners();
    } catch (error) {
      print("Error is selected value $error");
    }
  }

  goToMe() async {
    try {
      _myMarker = [];
      _myMarker.add(Marker(
          markerId: MarkerId('0'),
          position: LatLng(_lat, _lng),
          draggable: true,
          onDragEnd: (dragEndPosition) {
            print(dragEndPosition);
          }));
      GoogleMapController controller = await _controllerCompleter.future;
      controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target: LatLng(_lat, _lng),
        zoom: 16,
      )));
      locationName();
      notifyListeners();
    } catch (error) {
      print("Error go to me: $error");
    }
  }

  selectDate(context) async {
    DateTime picked = await showDatePicker(
        context: context,
        initialDate: _selectedDate,
        initialDatePickerMode: DatePickerMode.day,
        firstDate: DateTime(2021),
        lastDate: DateTime(2121));
    if (picked != null) {
      _selectedDate = picked;
      _dateController.text = DateFormat("dd MMM yyyy").format(_selectedDate);
    }
    print("date : " + _dateController.text);
    timeStamp();
    notifyListeners();
  }

  selectTime(dateTime) async {
    try {
      print("dateTime $dateTime");
      _selectedTime = dateTime;

      _hour = _selectedTime.hour.toString();
      _minute = _selectedTime.minute.toString();
      _time = _hour + ' : ' + _minute;
      _timeController.text = _time;
      _timeController.text = formatDate(
          DateTime(_selectedDate.year, _selectedDate.month, _selectedDate.day,
              _selectedTime.hour, _selectedTime.minute),
          [HH, ':', nn]).toString();
      print("selectedTime :$_selectedTime $_hour $_minute");
      var sec = (new DateTime.now());
      final dateStr =
          "${_selectedDate.year}-${_selectedDate.month}-${_selectedDate.day} ${_hour}:${_minute}:${sec.second}";
      final formatter = DateFormat(r'''yyyy-mm-dd hh:mm:ss''');
      print("dateStr :$dateStr");
      final dateTimeFromStr = formatter.parse(dateStr);
      _timeStampValue = dateTimeFromStr.toUtc().millisecondsSinceEpoch;

      notifyListeners();
    } catch (error) {
      print("Error select time: $error");
    }
  }

  submitValue() async {
    try {
      String txtReportDetails = textNote.text;
      if (textNote.text == "") {
        txtReportDetails = 'ไม่ใส่ข้อมูล';
      }
      //case user input 0 number
      if (_textElephantAmount.text == "0" ||
          _textElephantAmount.text == "00" ||
          _textElephantAmount.text == "000" ||
          _textElephantAmount.text == "000") {
        _textElephantAmount.text = '1';
      }
      Report report = new Report();
      if (_textElephantAmount.text == "" ||
          // _textNote.text == "" ||
          imagesFile == null ||
          _textLocationName.text == "" ||
          _lat == null ||
          _lng == null) {
        _valueCheck = false;
      } else {
        print("UserLat: $_userLat");
        print("UserLng: $_userLng");
        print("GlobalLat: $_lat");
        print("GlobalLng: $_lng");

        //Initial elephantCharacteristics
        List<ElephantCharacteristics> elephantChaList =
            new List<ElephantCharacteristics>();
        for (int i = 0; i < elpCharacterList.length; i++) {
          elephantChaList.add(ElephantCharacteristics(
              elephantCharacterId: "E${i + 1}",
              elephantCharacterName: elpCharacterList[i],
              active: isSelected[i]));
        }
        //convert to BASE64
        final bytes = Io.File(imagesFile.path).readAsBytesSync();
        String img64 = base64Encode(bytes);

        //get UUID
        String accountId = await getAccountId();
        log(accountId, name: "accountId");

        report
          ..reportId = ""
          ..accountId = accountId
          ..missionId = ""
          ..locationGroupId = ""
          ..timeStamp = _timeStampValue
          ..elephantAmount = int.parse(textElephantAmount.text)
          ..reportDetails = txtReportDetails
          ..reportStatus = 0
          ..image = img64
          ..locationName = textLocationName.text
          ..pinLat = _lat
          ..pinLng = _lng

          ///TODO: create pinLatLng and userLatLng!
          ..userLat = _userLat
          ..userLng = _userLng
          ..elephantCharacteristicsList = elephantChaList;
        //send report
        ReportApi reportApi = new ReportApi();
        BaseModel<String> res = await reportApi.sendReport(report);
        log('response: ' + res.data.toString());
        //print(report.toJson());
        _valueCheck = true;
      }
      notifyListeners();
    } catch (error) {
      print("Error submit value: $error");
    }
  }

  clearData() {
    try {
      _loading = true;
      _myMarker = [];
      _textLocationName = new TextEditingController(text: 'สถานที่เกิดเหตุ');
      _textElephantAmount = new TextEditingController(text: "");
      _textNote = new TextEditingController(text: "");
      _isSelected = [false, false, false, false];
      _imagesFile = null;
      _selectedTime = TimeOfDay.now();
      _favoriteLocationValue = 1;
      _controllerCompleter = Completer();
      notifyListeners();
    } catch (error) {
      print("Error clear data $error");
    }
  }

  getAccountId() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      return await prefs.get(Values.authenicized_key);
    } catch (error) {
      print("Error get account ID $error");
    }
  }
}
