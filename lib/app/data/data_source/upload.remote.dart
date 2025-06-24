import 'dart:io';

import 'package:flutter_getx_base/app/core/service/dio/dio.helper.dart';
import 'package:flutter_getx_base/app/core/settings/endpoints.dart';
import 'package:injectable/injectable.dart';

abstract class UploadDataSource {
  Future<HttpResponse> postUploadFile(String userId, File file);
  Future<HttpResponse> deleteFile(String url);
}

@LazySingleton(as: UploadDataSource)
class UploadRemoteImpl implements UploadDataSource {
  @override
  Future<HttpResponse> postUploadFile(String userId, File file) async {
    return await DioHelper.uploadFile(
        '${Endpoints.uploadFile}${userId}/single-file/image?key=',
        file: file);
  }

  @override
  Future<HttpResponse> deleteFile(String url) async {
    return await DioHelper.delete(url);
  }
}
