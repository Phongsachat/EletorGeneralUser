import 'package:Eletor/ui/home/home_view_model.dart';
import 'package:Eletor/utils/shared_preference.dart';
import 'package:Eletor/utils/values.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked/stacked.dart';

class HeaderAppViewModel extends BaseViewModel{


  bool _isLogOutSuccess = false;

  bool _isNotificationShow = false;

  set setNotificationShow(bool show) => _isNotificationShow = _isNotificationShow = show;

  get isNotificationShow => _isNotificationShow;

  get isLogOutSuccess => _isLogOutSuccess;

  signOut(HomeViewModel vm) async {

    print("${vm.name} ${vm.position} ${vm.imageUrl} ");
    SharedPreferences pref = await SharedPreferenceUtils.initialize();

    SharedPreferenceUtils.clearAll();
    if(!(pref.containsKey(Values.authenicized_key))){
      _isLogOutSuccess = true;
      _isNotificationShow = true;
      notifyListeners();
    }
  }

}