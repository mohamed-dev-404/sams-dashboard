class EndPoints {
  EndPoints._();

  //? --- Admin User  --- ;

  static String users = 'admin/users';

  static String toggleUserActivation(String userId) {
    return 'admin/users/$userId/toggle-activation';
  }

  static String changeRole(String userId) {
    return 'admin/users/$userId/role';
  }

  static const String roles = 'admin/roles';

  //? --- Auth  --- ;
  static String login = 'api/v1/auth/login';
  static String refresh = 'api/v1/auth/refresh';
  static String forgetPassword = 'api/v1/auth/forgot-password';
  static String virfyOTP = 'api/v1/auth/verify-otp';
  static String resetPassword = 'api/v1/auth/reset-password';
  static String resendOTP = 'api/v1/auth/resend-code';
}
