
import 'package:Eletor/api/baseurl.dart';
import 'package:Eletor/models/report/report.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';

part 'report_services.g.dart';

@RestApi(baseUrl: BaseUrl.itUrl)
abstract class ReportServices {
  factory ReportServices(Dio dio) = _ReportServices;

  @POST("report/add")
  @FormUrlEncoded()
  Future<String> sendReport(@Body() Report report);
}
