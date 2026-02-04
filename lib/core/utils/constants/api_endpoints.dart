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
  // static String logIn = 'auth/login';
  // static String register = 'auth/register';
  // static String forgetpassword = 'auth/forgotten-password';
  // static String virfyOTP = 'auth/verify-token';
  // static String resetPassword = 'auth/reset-password';
  // static String addProduct = 'admin/products';

  // ... more endpoints
}
