// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_services.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

class _UserServices implements UserServices {
  _UserServices(this._dio, {this.baseUrl}) {
    ArgumentError.checkNotNull(_dio, '_dio');
    baseUrl ??= 'https://eletor.herokuapp.com/eletor/api/';
  }

  final Dio _dio;

  String baseUrl;

  @override
  Future<ResponseLoginModel> authenticizedUser(loginModel) async {
    ArgumentError.checkNotNull(loginModel, 'loginModel');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(loginModel?.toJson() ?? <String, dynamic>{});
    _data.removeWhere((k, v) => v == null);
    final _result = await _dio.request<Map<String, dynamic>>('officer/login',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'POST',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = ResponseLoginModel.fromJson(_result.data);
    return value;
  }

  @override
  Future<UserInfoModel> getUserInfo(userIdModel) async {
    ArgumentError.checkNotNull(userIdModel, 'userIdModel');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(userIdModel?.toJson() ?? <String, dynamic>{});
    _data.removeWhere((k, v) => v == null);
    final _result = await _dio.request<Map<String, dynamic>>('officer/getInfo',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'POST',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = UserInfoModel.fromJson(_result.data);
    return value;
  }

  @override
  Future<ResponseRegisterModel> register(userInfoAccount) async {
    ArgumentError.checkNotNull(userInfoAccount, 'userInfoAccount');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(userInfoAccount?.toJson() ?? <String, dynamic>{});
    _data.removeWhere((k, v) => v == null);
    final _result = await _dio.request<Map<String, dynamic>>('general/register',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'POST',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = ResponseRegisterModel.fromJson(_result.data);
    return value;
  }
}
