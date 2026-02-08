//todo auth repos
import 'package:dartz/dartz.dart';
import 'package:sams_dashboard/features/auth/data/models/login_response_model.dart';

abstract class AuthRepo {
  // Returns Either<Failure, LoginModel> using dartz or similar
  Future<Either<String, LoginResponseModel>> login({required String email, required String password});
  
  // Forgot Password (usually returns a success message or void)
  Future<Either<String, String>> forgotPassword({required String email});
  
  // Verify OTP
  Future<Either<String, String>> verifyOtp({required String email, required String otp});
  
  // Reset Password
  Future<Either<String, String>> resetPassword({required String email, required String otp, required String newPassword});
}