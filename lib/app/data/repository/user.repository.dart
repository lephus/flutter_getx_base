import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
//
import 'package:flutter_getx_base/app/core/service/dio/failure.dart';
import 'package:flutter_getx_base/app/data/data_source/user.remote.dart';
import 'package:flutter_getx_base/app/data/models/login.model.dart';
import 'package:flutter_getx_base/app/data/models/register.model.dart';
import 'package:flutter_getx_base/app/data/models/token.model.dart';
import 'package:flutter_getx_base/app/data/models/user.model.dart';
import 'package:flutter_getx_base/generated/locales.g.dart';
import 'package:get/get.dart';
import 'package:injectable/injectable.dart';

@LazySingleton()
class UserRepository {
  final UserDataSource userDataSource;
  UserRepository({
    required this.userDataSource,
  });

  Future<Either<Failure, UserModel>> authMe() async {
    try {
      final response = await userDataSource.authMe();
      return Right(UserModel.fromJson(response.body['data']));
    } catch (error) {
      return const Left(ServerFailure());
    }
  }

  Future<Either<Failure, Map<String, dynamic>>> login(
      LoginModel loginModel) async {
    try {
      final response = await userDataSource.login(loginModel);
      final user = UserModel.fromJson(response.body['data']['user']);
      final token = TokenModel.fromJson(response.body['data']['token']);
      return Right({'user': user, 'token': token});
    } on DioException catch (_) {
      return Left(ServerFailure(
          message: LocaleKeys.login_email_or_password_incorrect.tr));
    } catch (error) {
      return const Left(ServerFailure());
    }
  }

  Future<Either<Failure, Map<String, dynamic>>> register(
      RegisterModel registerModel) async {
    try {
      final response = await userDataSource.register(registerModel);
      final user = UserModel.fromJson(response.body['data']['user']);
      final token = TokenModel.fromJson(response.body['data']['token']);
      return Right({'user': user, 'token': token});
    } catch (error) {
      return const Left(ServerFailure());
    }
  }

  Future<Either<Failure, bool>> deleteAccount(String userId) async {
    try {
      await userDataSource.deleteAccount(userId);
      return const Right(true);
    } catch (error) {
      return const Left(ServerFailure());
    }
  }
}
