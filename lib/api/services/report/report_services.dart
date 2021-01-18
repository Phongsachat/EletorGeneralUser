
import 'package:Eletor/models/report/report.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';

part 'report_services.g.dart';

@RestApi(baseUrl: "http://192.168.1.239:3000/eletor/api/")
abstract class ReportServices {
  factory ReportServices(Dio dio) = _ReportServices;

  @POST("report/add")
  @FormUrlEncoded()
  Future<String> sendReport(@Body() Report report);
}
