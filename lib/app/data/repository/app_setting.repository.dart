import 'package:dartz/dartz.dart';
import 'package:flutter_getx_base/app/core/service/dio/failure.dart';
import 'package:flutter_getx_base/app/data/data_source/app_setting.remote.dart';
//
import 'package:injectable/injectable.dart';

@LazySingleton()
class AppSettingRepository {
  final AppSettingDataSource appSettingDataSource;
  AppSettingRepository({
    required this.appSettingDataSource,
  });

  Future<Either<Failure, List<String>>> getUnPlashImages(
    String query,
    int page,
    int perPage,
  ) async {
    try {
      final response = await appSettingDataSource.getUnPlashImages(
        query,
        page,
        perPage,
      );
      List<String> regular = [];

      if (query.isNotEmpty) {
        for (var item in response.body['results']) {
          regular.add(item['urls']['regular']);
        }
      } else {
        for (var item in response.body) {
          regular.add(item['urls']['regular']);
        }
      }

      return Right(regular);
    } catch (error) {
      return const Left(ServerFailure());
    }
  }
}
