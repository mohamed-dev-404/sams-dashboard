enum PasswordResetStatus {
  initial,    // Default state: User is on Forgot Password screen
  loading,    // Common state: API request is in progress (show loading spinner)
  codeSent,   // Success state for Step 1: Navigate to OTP screen
  verified,   // Success state for Step 2: Navigate to New Password screen
  success,    // Success state for Step 3: Password changed, navigate to Login
  failure,    // Error state: Show error message (SnackBar/Toast)
}

class PasswordResetState {
  final String? email;
  final String? resetToken;
  final PasswordResetStatus status;
  final String? errorMessage;

  const PasswordResetState({
    this.email,
    this.resetToken,
    this.status = PasswordResetStatus.initial,
    this.errorMessage,
  });

  PasswordResetState copyWith({
    String? email,
    String? resetToken,
    PasswordResetStatus? status,
    String? errorMessage,
  }) {
    return PasswordResetState(
      email: email ?? this.email,
      resetToken: resetToken ?? this.resetToken,
      status: status ?? this.status,
      errorMessage: errorMessage,
    );
  }
}