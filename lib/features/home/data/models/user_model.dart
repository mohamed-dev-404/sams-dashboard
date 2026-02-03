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
      id: json['_id'] as String,
      name: json['name'] as String,
      email: json['academicEmail'] as String,
      academicId: json['academicId'] as String,
      profilePic: json['profilePic'] as String?,

      //* Status mapping: convert boolean value to enum
      status: json['isActive'] == true
          ? UserStatus.active
          : UserStatus.inactive,

      //* Role mapping: use the static method we created
      role: UserRole.fromString(json['role'] as String),
    );
  }
}
