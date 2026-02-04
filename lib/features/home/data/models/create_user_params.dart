import 'package:sams_dashboard/core/utils/constants/api_keys.dart';

class CreateUserParams {
  final String name;
  final String email;
  final String academicId;
  final String password;
  final String roleId;

  const CreateUserParams({
    required this.name,
    required this.email,
    required this.academicId,
    required this.password,
    required this.roleId,
  });

  Map<String, dynamic> toJson() {
    return {
      ApiKeys.name: name,
      ApiKeys.academicEmail: email,
      ApiKeys.academicId: academicId,
      ApiKeys.password: password,
      ApiKeys.roleId: roleId,
    };
  }
}
