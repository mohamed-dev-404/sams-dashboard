import 'package:sams_dashboard/core/utils/constants/api_keys.dart';
import 'package:sams_dashboard/features/home/data/enum/user_role.dart';
import 'package:sams_dashboard/features/home/data/enum/user_status.dart';

class UserModel {
  final String id;
  final String name;
  final String email;
  final String academicId;
  final String? profilePic;
  final UserStatus status;
  final UserRole role;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.academicId,
    this.profilePic,
    required this.status,
    required this.role,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json[ApiKeys.id] as String,
      name: json[ApiKeys.name] as String,
      email: json[ApiKeys.academicEmail] as String,
      academicId: json[ApiKeys.academicId] as String,
      profilePic: json[ApiKeys.profilePic] as String?,

      //* Status mapping: convert boolean value to enum
      status: json[ApiKeys.isActive] == true
          ? UserStatus.active
          : UserStatus.inactive,

      //* Role mapping: use the static method we created
      role: UserRole.fromString(json[ApiKeys.role] as String),
    );
  }
}
