import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/cupertino.dart';

class HistoryViewModel extends ChangeNotifier{
  String _maxLengthLocationName;
  String _stringTimeStamp;
  int _length = 0;
  DateTime _date;

  String get maxLengthLocationName => _maxLengthLocationName;

  String get stringTimeStamp => _stringTimeStamp;

  int get length => _length;

  DateTime get date => _date;

  maxLength(locationName) {
    try{
      int _maxLengthValue;
      if (locationName.length > 17) {
        _maxLengthValue = 17;
        _maxLengthLocationName = locationName.replaceRange(
            _maxLengthValue, locationName.toString().length, '...');
      } else {
        _maxLengthValue = locationName.toString().length;
        _maxLengthLocationName = locationName;
      }
      notifyListeners();
    }catch(error){
      print("Error max length: $error");
    }
  }

  convertTimeStamp(timeStamp){
    try{
      _date = DateTime.fromMillisecondsSinceEpoch(timeStamp);
      _stringTimeStamp = DateFormat('dd MMMM yyyy HH:mm').format(_date);
    }catch(error){
      print("Error convert time stamp: $error");
    }

  }

  maxItemCount(lengthValue){
    try{
      if(lengthValue!=null){
        _length = lengthValue;
      }else if(lengthValue>10){
        _length = 10;
      }else{
        _length = 0;
      }
      notifyListeners();
    }catch(error){
      print("Error max item count: $lengthValue");
    }
  }

}
