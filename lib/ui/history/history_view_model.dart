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
  }

  convertTimeStamp(timeStamp){
    _date = DateTime.fromMillisecondsSinceEpoch(timeStamp);
    _stringTimeStamp = DateFormat('dd MMMM yyyy HH:mm').format(_date);

  }

  maxItemCount(lengthValue){
    if(lengthValue!=null){
      _length = lengthValue;
    }else if(lengthValue>10){
      _length = 10;
    }else{
      _length = 0;
    }
    notifyListeners();
  }

}
