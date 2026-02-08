import 'package:dartz/dartz.dart';
import 'package:sams_dashboard/core/network/api_consumer.dart';
import 'package:sams_dashboard/features/auth/data/models/login_response_model.dart';
import 'package:sams_dashboard/features/auth/data/repos/auth_repo.dart';

class AuthRepoImpl implements AuthRepo {
  final ApiConsumer api;

  AuthRepoImpl(this.api);

  @override
  Future<Either<String, String>> forgotPassword({required String email}) {
    // TODO: implement forgotPassword
    throw UnimplementedError();
  }

  @override
  Future<Either<String, LoginResponseModel>> login({
    required String email,
    required String password,
  }) {
    // TODO: implement login
    throw UnimplementedError();
  }

  @override
  Future<Either<String, String>> resetPassword({
    required String email,
    required String otp,
    required String newPassword,
  }) {
    // TODO: implement resetPassword
    throw UnimplementedError();
  }

  @override
  Future<Either<String, String>> verifyOtp({
    required String email,
    required String otp,
  }) {
    // TODO: implement verifyOtp
    throw UnimplementedError();
  }
}
