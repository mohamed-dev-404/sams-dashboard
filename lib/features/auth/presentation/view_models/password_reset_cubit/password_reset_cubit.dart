import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sams_dashboard/features/auth/data/repos/auth_repo.dart';
import 'package:sams_dashboard/features/auth/presentation/view_models/password_reset_cubit/password_reset_state.dart';

class PasswordResetCubit extends Cubit<PasswordResetState> {
  // ignore: unused_field
  final AuthRepo _authRepo;

  PasswordResetCubit(this._authRepo) : super(const PasswordResetState());

  //? ============================================================
  //? STEP 1: FORGOT PASSWORD SCREEN
  // Endpoint: /api/v1/auth/forgot-password
  // ?============================================================
  Future<void> sendResetCode({required String email}) async {
    emit(state.copyWith(status: PasswordResetStatus.loading));

    // Result should update status to .codeSent upon success
    // UI Listener: if (state.status == PasswordResetStatus.codeSent) -> Go to OTP
  }

  //? ============================================================
  //? STEP 2: VERIFY OTP SCREEN
  // Endpoint: /api/v1/auth/verify-otp
  //? ============================================================
  Future<void> verifyOtp({required String otp}) async {
    emit(state.copyWith(status: PasswordResetStatus.loading));

    // Result should update status to .verified and store resetToken
    // UI Listener: if (state.status == PasswordResetStatus.verified) -> Go to Reset Password
  }

  //? ============================================================
  //? STEP 3: RESET PASSWORD SCREEN
  // Endpoint: /api/v1/auth/reset-password
  //? ============================================================
  Future<void> resetPassword({
    required String newPassword,
    required String confirmPassword,
  }) async {
    emit(state.copyWith(status: PasswordResetStatus.loading));

    // Result should update status to .success
    // UI Listener: if (state.status == PasswordResetStatus.success) -> Go to Login
  }

  //* ============================================================
  //* HELPER: RESEND CODE (OTP SCREEN)
  // Endpoint: /api/v1/auth/resend-code
  //* ============================================================
  Future<void> resendCode() async {
    emit(state.copyWith(status: PasswordResetStatus.loading));
    // Implementation for resending code using state.email
  }
}
