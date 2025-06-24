// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:flutter_getx_base/app/core/service/dio/dio.helper.dart'
    as _i763;
import 'package:flutter_getx_base/app/core/service/firebase_message.service.dart'
    as _i59;
import 'package:flutter_getx_base/app/core/service/local_notification.service.dart'
    as _i777;
import 'package:flutter_getx_base/app/data/data_source/app_setting.remote.dart'
    as _i169;
import 'package:flutter_getx_base/app/data/data_source/upload.remote.dart'
    as _i464;
import 'package:flutter_getx_base/app/data/data_source/user.remote.dart'
    as _i51;
import 'package:flutter_getx_base/app/data/repository/app_setting.repository.dart'
    as _i627;
import 'package:flutter_getx_base/app/data/repository/upload.repository.dart'
    as _i392;
import 'package:flutter_getx_base/app/data/repository/user.repository.dart'
    as _i200;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

// initializes the registration of main-scope dependencies inside of GetIt
_i174.GetIt initGetIt(
  _i174.GetIt getIt, {
  String? environment,
  _i526.EnvironmentFilter? environmentFilter,
}) {
  final gh = _i526.GetItHelper(
    getIt,
    environment,
    environmentFilter,
  );
  gh.factory<_i777.LocalNotificationService>(
      () => _i777.LocalNotificationService());
  gh.factory<_i763.DioHelper>(() => _i763.DioHelper());
  gh.factory<_i59.FirebaseMessageService>(() => _i59.FirebaseMessageService());
  gh.lazySingleton<_i169.AppSettingDataSource>(
      () => _i169.AppSettingRemoteImpl());
  gh.lazySingleton<_i464.UploadDataSource>(() => _i464.UploadRemoteImpl());
  gh.lazySingleton<_i51.UserDataSource>(() => _i51.UserRemoteImpl());
  gh.lazySingleton<_i200.UserRepository>(
      () => _i200.UserRepository(userDataSource: gh<_i51.UserDataSource>()));
  gh.lazySingleton<_i627.AppSettingRepository>(() => _i627.AppSettingRepository(
      appSettingDataSource: gh<_i169.AppSettingDataSource>()));
  gh.lazySingleton<_i392.UploadRepository>(() =>
      _i392.UploadRepository(uploadDataSource: gh<_i464.UploadDataSource>()));
  return getIt;
}
