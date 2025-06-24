import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter_getx_base/app/core/service/dio/failure.dart';
import 'package:flutter_getx_base/app/core/widgets/message.util.dart';
//
import 'package:flutter_getx_base/app/data/data_source/upload.remote.dart';
import 'package:injectable/injectable.dart';

@LazySingleton()
class UploadRepository {
  final UploadDataSource uploadDataSource;
  UploadRepository({
    required this.uploadDataSource,
  });

  Future<Either<Failure, dynamic>> uploadFile(String userId, File file) async {
    try {
      MessageDialog.showFinalizingPleaseWait();
      final response = await uploadDataSource.postUploadFile(userId, file);
      MessageDialog.hideLoading();
      return Right(response.body.data['data']['result']);
    } catch (error) {
      return const Left(ServerFailure());
    }
  }

  Future<Either<Failure, bool>> deleteFile(String url) async {
    try {
      if(url.isEmpty){
        return const Right(true);
      }
      await uploadDataSource.deleteFile(url);
      return const Right(true);
    } catch (error) {
      return const Left(ServerFailure());
    }
  }
}
