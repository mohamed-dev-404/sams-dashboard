import 'package:dartz/dartz.dart';
import 'package:sams_dashboard/core/cache/get_storage.dart';
import 'package:sams_dashboard/core/cache/secure_storage.dart';
import 'package:sams_dashboard/core/errors/exceptions/api_exception.dart';
import 'package:sams_dashboard/core/network/api_consumer.dart';
import 'package:sams_dashboard/core/utils/constants/api_endpoints.dart';
import 'package:sams_dashboard/core/utils/constants/api_keys.dart';
import 'package:sams_dashboard/core/utils/constants/cache_keys.dart';
import 'package:sams_dashboard/features/auth/data/models/login_model/login_model.dart';
import 'package:sams_dashboard/features/auth/data/repos/auth_repo.dart';

class AuthRepoImpl implements AuthRepo {
  final ApiConsumer api;

  AuthRepoImpl(this.api);

  //! login request
  @override
  Future<Either<String, LoginModel>> login({
    required String email,
    required String password,
  }) async {
    try {

      // hit login request
      Map<String, dynamic> response = await api.post(
        EndPoints.login,
        data: {
          ApiKeys.academicEmail: email,
          ApiKeys.password: password,
        },
      );

      //parsing and initialize loginModel
      final dataJson = response[ApiKeys.data];
      LoginModel loginModel = LoginModel.fromJson(dataJson);

      //cache tokens and required data to display in home
      await _cacheUserData(loginModel);

      return Right(loginModel); // success case, return loginModel

    } on ApiException catch (e) {
      return Left(e.errorModel.errorMessage); // failure case
    } catch (e) {
      return Left(e.toString()); // failure case
    }
  }


  //! forget password request
  @override
  Future<Either<String, String>> forgotPassword({required String email}) {

    

    throw UnimplementedError();
  }

  @override
  Future<Either<String, String>> resetPassword({
    required String email,
    required String otp,
    required String newPassword,
  }) {
    throw UnimplementedError();
  }

  @override
  Future<Either<String, String>> verifyOtp({
    required String email,
    required String otp,
  }) {
    throw UnimplementedError();
  }


//* helper methods
  Future<void> _cacheUserData(LoginModel loginModel) async {
    await SecureStorageService.instance.saveAccessToken(
      loginModel.accessToken ?? '',
    );
    await SecureStorageService.instance.saveRefreshToken(
      loginModel.refreshToken ?? '',
    );
    await GetStorageHelper.write(
      CacheKeys.name,
      loginModel.user?.name ?? '',
    );
    await GetStorageHelper.write(
      CacheKeys.academicEmail,
      loginModel.user?.academicEmail ?? '',
    );
    await GetStorageHelper.write(
      CacheKeys.profilePic,
      loginModel.user?.profilePic ?? '',
    );
  }
}
