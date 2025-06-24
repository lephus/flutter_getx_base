import 'package:flutter_getx_base/app/core/service/dio/dio.helper.dart';
import 'package:injectable/injectable.dart';

abstract class AppSettingDataSource {
  Future<HttpResponse> getUnPlashImages(String query, int page, int perPage);
}

@LazySingleton(as: AppSettingDataSource)
class AppSettingRemoteImpl implements AppSettingDataSource {
  @override
  Future<HttpResponse> getUnPlashImages(
    String query,
    int page,
    int perPage,
  ) async {
    // Application ID 577612
    // Access Key 8D9ojwKtDVH3zkg2WaBL-TBvzt6OaOv7_hxFWKOJ--s
    // Secret key nBOWMmOi_OCRkEev07ja41-oTfnKVg3aeE0_Ms6WfMM
    String accessKey = '8D9ojwKtDVH3zkg2WaBL-TBvzt6OaOv7_hxFWKOJ--s';
    String url =
        'https://api.unsplash.com/search/photos?page=$page&per_page=$perPage&client_id=$accessKey&order_by=latest';
    if (query.isNotEmpty) {
      url += '&query=$query';
    } else {
      url =
          'https://api.unsplash.com/photos?page=$page&per_page=$perPage&client_id=$accessKey&order_by=latest';
    }
    return await DioHelper.get(url);
  }
}
