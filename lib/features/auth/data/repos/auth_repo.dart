//todo auth repos
import 'package:dartz/dartz.dart';
import 'package:sams_dashboard/features/auth/data/models/login_model/login_model.dart';

abstract class AuthRepo {
  //? login
  Future<Either<String, LoginModel>> login({
    required String email,
    required String password,
  });

  //? Forgot Password (usually returns a failure message or void)
  Future<Either<String, void>> forgotPassword({required String email});

  // Verify OTP
  Future<Either<String, String>> verifyOtp({
    required String email,
    required String otp,
  });

  // Reset Password
  Future<Either<String, String>> resetPassword({
    required String email,
    required String otp,
    required String newPassword,
  });
}
