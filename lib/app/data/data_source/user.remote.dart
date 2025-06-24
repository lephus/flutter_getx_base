import 'package:flutter_getx_base/app/core/service/dio/dio.helper.dart';
import 'package:flutter_getx_base/app/core/settings/endpoints.dart';
import 'package:flutter_getx_base/app/core/utils/remove_null_from_json.util.dart';
import 'package:flutter_getx_base/app/data/models/login.model.dart';
import 'package:flutter_getx_base/app/data/models/register.model.dart';
import 'package:injectable/injectable.dart';

abstract class UserDataSource {
  Future<HttpResponse> login(LoginModel loginModel);
  Future<HttpResponse> register(RegisterModel loginModel);
  Future<HttpResponse> authMe();
  Future<HttpResponse> deleteAccount(String userId);
}

@LazySingleton(as: UserDataSource)
class UserRemoteImpl implements UserDataSource {
  @override
  Future<HttpResponse> authMe() async {
    return await DioHelper.get(Endpoints.authMe);
  }

  @override
  Future<HttpResponse> login(LoginModel loginModel) async {
    return await DioHelper.post(Endpoints.login, loginModel.toJson());
  }

  @override
  Future<HttpResponse> register(RegisterModel registerModel) async {
    return await DioHelper.post(
        Endpoints.register, removeNullFieldsFromJson(registerModel.toJson()));
  }

  @override
  Future<HttpResponse> deleteAccount(String userId) async {
    return await DioHelper.delete('${Endpoints.deleteAccount}$userId');
  }
}
