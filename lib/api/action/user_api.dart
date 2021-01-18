

import 'package:Eletor/api/base_model/api_error_handling.dart';
import 'package:Eletor/api/base_model/base_model.dart';
import 'package:Eletor/api/services/user/user_services.dart';
import 'package:Eletor/models/user/login_model.dart';
import 'package:Eletor/models/user/response_login_model.dart';
import 'package:Eletor/models/user/response_register_model.dart';
import 'package:Eletor/models/user/user_id_model.dart';
import 'package:Eletor/models/user/user_info_account.dart';
import 'package:Eletor/models/user/user_info_model.dart';
import 'package:dio/dio.dart';

Dio dio;
UserServices userServices;
class UserApi{

  UserApi() {
    dio = new Dio();
    userServices = new UserServices(dio);
  }

  Future<BaseModel<ResponseRegisterModel>> register(UserInfoAccount userInfoAccount) async {
    ResponseRegisterModel response;

    print("userInfoAccount ${userInfoAccount.toJson()}");
    try {
      response = await userServices.register(userInfoAccount);

      print(response);
    } catch (error, stacktrace) {
      print("Exception occurred: $error stackTrace: $stacktrace");
      return BaseModel()..setException(ServerError.withError(error: error));
    }
    return BaseModel()..data = response;
  }

}
