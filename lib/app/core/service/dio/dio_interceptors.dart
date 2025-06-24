import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_getx_base/app/core/service/dio/token_manager.dart';
import 'package:flutter_getx_base/app/core/settings/app_setting.dart';
import 'package:flutter_getx_base/app/core/settings/endpoints.dart';
import 'package:flutter_getx_base/app/data/models/token.model.dart';

class TokenInterceptor extends InterceptorsWrapper {
  final Dio _dio;
  final Options? options;
  final TokenManager tokenManager = const TokenManager();
  final Dio _tokenDio = Dio();
  String? _accessToken;

  TokenInterceptor(this._dio, this.options);

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    _accessToken = await tokenManager.getAccessToken();
    if (!options.headers.containsKey(HttpHeaders.authorizationHeader)) {
      if (_accessToken != null) {
        options.headers.addAll({
          HttpHeaders.authorizationHeader:
              '${AppSetting.tokenType} $_accessToken',
        });
      }
    }
    handler.next(options);
  }

  @override
  Future<void> onError(
      DioException err, ErrorInterceptorHandler handler) async {
    try {
      if (_accessToken != null && err.response?.statusCode == 401) {
        await _refreshToken(err, handler, options);
        // Recall Api with new access token
        err.requestOptions.headers[HttpHeaders.authorizationHeader] =
            '${AppSetting.tokenType} $_accessToken';
        final opts = Options(
          method: err.requestOptions.method,
          headers: err.requestOptions.headers,
        );
        final cloneReq = await _dio.request(
          err.requestOptions.path,
          options: opts,
          data: err.requestOptions.data,
          queryParameters: err.requestOptions.queryParameters,
        );
        log('💫 RECALL: => ${err.requestOptions.path}');
        return handler.resolve(cloneReq);
      }
    } catch (e) {
      log(
        'onError: ${err.response?.statusCode} - onError: ${err.response}',
      );
    }
    return handler.next(err);
  }

  Future<void> _refreshToken(
    DioException err,
    ErrorInterceptorHandler handler,
    Options? options,
  ) async {
    try {
      String refreshToken = await tokenManager.getRefreshToken();
      if (refreshToken.isEmpty) {
        tokenManager.cleanAuthBox();
        return;
      }
      // _tokenDio.options.headers[AppConstants.tokenType] = _accessToken;
      log('Refresh Token REQUEST: POST => ${Endpoints.refreshToken}');
      _tokenDio.options.headers['refreshToken'] = refreshToken;
      final response = await _tokenDio
          .post(Endpoints.refreshToken, data: {'refreshToken': refreshToken});
      TokenModel tokenData = TokenModel.fromJson(response.data['data']);

      _accessToken = tokenData.accessToken;
      await tokenManager.setAccessToken(tokenData.accessToken);
      await tokenManager.setRefreshToken(tokenData.refreshToken);
      await tokenManager.setTokenExpiredTime(tokenData.expiresIn);
    } catch (_) {
      tokenManager.cleanAuthBox();
    }
  }
}
