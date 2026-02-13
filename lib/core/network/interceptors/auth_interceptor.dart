import 'package:dio/dio.dart';
import 'package:sams_dashboard/core/cache/secure_storage.dart';
import 'package:sams_dashboard/core/network/api_consumer.dart';
import 'package:sams_dashboard/core/utils/constants/api_endpoints.dart';
import 'package:sams_dashboard/core/utils/constants/api_keys.dart';
import 'package:sams_dashboard/features/auth/data/models/login_model/login_model.dart';

class AuthInterceptor extends Interceptor {
  final Dio dio;
  final ApiConsumer api;

  AuthInterceptor(this.dio, this.api);

  @override
  Future onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    if (err.response?.statusCode == 401) {
      final newAccessToken = await _refreshToken();

      if (newAccessToken != null) {
        err.requestOptions.headers[ApiKeys.authorization] =
            'Bearer $newAccessToken';

        final response = await dio.fetch(err.requestOptions);
        return handler.resolve(response);
      }
    }

    return handler.next(err);
  }

  Future<String?> _refreshToken() async {
    // get old refresh token to use it in request
    final oldRefreshToken = await SecureStorageService.instance
        .getRefreshToken();

    //hit refresh token request
    final Map<String, dynamic> response = await api.post(
      EndPoints.refresh,
      data: {
        ApiKeys.refreshToken: oldRefreshToken,
      },
    );

    //parsing and initialize loginModel
    final dataJson = response[ApiKeys.data];
    LoginModel loginModel = LoginModel.fromJson(dataJson);

    //cache new tokens
    await _cacheNewTokens(loginModel);

    //reyurn new access token to add it in header of current request
    return loginModel.accessToken;
  }

  Future<void> _cacheNewTokens(LoginModel loginModel) async {
    await SecureStorageService.instance.saveAccessToken(
      loginModel.accessToken ?? '',
    );
    await SecureStorageService.instance.saveRefreshToken(
      loginModel.refreshToken ?? '',
    );
  }
}
