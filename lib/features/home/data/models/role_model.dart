import 'package:sams_dashboard/core/utils/constants/api_keys.dart';
import 'package:sams_dashboard/features/home/data/enum/user_role.dart';

class RoleModel {
  final String id;
  final UserRole role;

  RoleModel({
    required this.id,
    required this.role,
  });

  factory RoleModel.fromJson(Map<String, dynamic> json) {
    return RoleModel(
      id: json[ApiKeys.id] as String,
      role: UserRole.fromString(json[ApiKeys.name] as String),
    );
  }
}
