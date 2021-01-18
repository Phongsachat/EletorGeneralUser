import 'package:Eletor/utils/string_values.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceUtils {

  static SharedPreferences _preferences;
  static Future<SharedPreferences> get _instance async => _preferences ?? await SharedPreferences.getInstance();


  /// Initialize [initialize]
  static Future<SharedPreferences> initialize() async{
    _preferences = await _instance;
    return _preferences;
  }

  /// * get string value by given [key]
  /// Set default value by given [defaultValue] it's optional
  /// actual default value is unknown string [StringValue.unknown]
  static getString(String key,[String defaultValue]){
    return _preferences.getString(key) ?? defaultValue ??  StringValue.unknown;
  }

  static setString(String key,String value){
    return _preferences.setString(key, value);
  }

  static clearSingle(String key){
    return _preferences.remove(key);
  }

  static clearAll(){
    return _preferences.clear();
  }
}
