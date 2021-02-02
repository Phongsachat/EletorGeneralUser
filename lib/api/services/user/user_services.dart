// @RestApi(baseUrl: "${Global.BASE_API_URL}")

import 'package:Eletor/api/baseurl.dart';
import 'package:Eletor/models/user/response_register_model.dart';
import 'package:Eletor/models/user/user_info_account.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'user_services.g.dart';

@RestApi(baseUrl: BaseUrl.itUrl)
abstract class UserServices {
  factory UserServices(Dio dio) = _UserServices;

  @POST("general/register")
  Future<ResponseRegisterModel> register(@Body() UserInfoAccount userInfoAccount);
}

