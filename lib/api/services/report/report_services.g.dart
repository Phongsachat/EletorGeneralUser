// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'report_services.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

class _ReportServices implements ReportServices {
  _ReportServices(this._dio, {this.baseUrl}) {
    ArgumentError.checkNotNull(_dio, '_dio');
    baseUrl ??= 'https://it1.sut.ac.th:9026/eletor/api/';
  }

  final Dio _dio;

  String baseUrl;

  @override
  Future<String> sendReport(report) async {
    ArgumentError.checkNotNull(report, 'report');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(report?.toJson() ?? <String, dynamic>{});
    _data.removeWhere((k, v) => v == null);
    final _result = await _dio.request<String>('report/add',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'POST',
            headers: <String, dynamic>{},
            extra: _extra,
            contentType: 'application/x-www-form-urlencoded',
            baseUrl: baseUrl),
        data: _data);
    final value = _result.data;
    return value;
  }
}
