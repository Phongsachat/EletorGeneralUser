// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_services.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

class _UserServices implements UserServices {
  _UserServices(this._dio, {this.baseUrl}) {
    ArgumentError.checkNotNull(_dio, '_dio');
    baseUrl ??= 'http://it1.sut.ac.th:9026/eletor/api/';
  }

  final Dio _dio;

  String baseUrl;

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
