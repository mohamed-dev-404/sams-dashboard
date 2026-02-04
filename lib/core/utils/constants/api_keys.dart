class ApiKeys {
  ApiKeys._();

  //? Common Keys
  static const String status = 'status';
  static const String data = 'data';
  static const String message = 'message';
  static const String validationErrors = 'validationErrors';

  //? User Model Keys
  static const String id = '_id';
  static const String name = 'name';
  static const String academicEmail = 'academicEmail';
  static const String academicId = 'academicId';
  static const String profilePic = 'profilePic';
  static const String isActive = 'isActive';
  static const String role = 'role';

  //? Pagination Keys
  static const String pagination = 'pagination';
  static const String totalElements = 'totalElements';
  static const String currentPage = 'currentPage';
  static const String size = 'size';
  static const String totalPages = 'totalPages';
  static const String hasNextPage = 'hasNextPage';
  static const String hasPrevPage = 'hasPrevPage';

  //? Fetch Users Params keys
  static const String page = 'page';
  static const String sortBy = 'sortBy';
  static const String sortOrder = 'sortOrder';
  static const String roleId = 'roleId';
  static const String search = 'search';

  //? Fetch Users Params Values
  static const String createdAt = 'createdAt';
  static const String desc = 'desc';

  //? Auth Keys
  static String authorization = 'Authorization';
  static String password = 'password';
  // static String errorMessage = 'businessErrorDescription';
  // static String email = 'email';
  // static String password = 'password';
  // static String confirmPassword = 'confirmPassword';
  // static String newPassword = 'newPassword';
  // static String firstName = 'firstName';
  // static String lastName = 'lastName';
  // static String phone = 'phone';
  // static String token = 'token';
  // static String tempToken = 'tempToken';
  // static String authorities = 'authorities';
  // static String authorization = 'Authorization';
  // static String name = 'name';
  // static String category = 'category';
  // static String description = 'description';
  // static String file = 'file';
  // ... more keys
}
