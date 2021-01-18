
import 'package:Eletor/api/base_model/api_error_handling.dart';
import 'package:Eletor/api/base_model/base_model.dart';
import 'package:Eletor/api/services/report/report_services.dart';
import 'package:Eletor/models/report/report.dart';
import 'package:dio/dio.dart';

Dio dio;
ReportServices reportServices;

class ReportApi {
  ReportApi() {
    dio = new Dio();
    reportServices = new ReportServices(dio);
  }

  Future<BaseModel<String>> sendReport(Report report) async {
    String response;

    try {
      response = await reportServices.sendReport(report);
    } catch (error, stacktrace) {
      print("Exception occurred: $error stackTrace: $stacktrace");
      return BaseModel()..setException(ServerError.withError(error: error));
    }
    return BaseModel()..data = response;
  }
}
