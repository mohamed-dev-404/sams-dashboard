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

  UserModel copyWith({
    String? profilePic,
    UserStatus? status,
    UserRole? role,
  }) {
    return UserModel(
      role: role ?? this.role,
      status: status ?? this.status,
      profilePic: profilePic ?? this.profilePic,
      id: id,
      name: name,
      email: email,
      academicId: academicId,
    );
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json[ApiKeys.id] as String? ?? '', //* Avoid crash if id is missing
      name: json[ApiKeys.name] as String? ?? 'No Name',
      email: json[ApiKeys.academicEmail] as String? ?? '',
      academicId: json[ApiKeys.academicId] as String? ?? '',
      profilePic: json[ApiKeys.profilePic] as String?,

      //*  Boolean check handles both true/false and null (default to false)
      status: (json[ApiKeys.isActive] as bool? ?? false)
          ? UserStatus.active
          : UserStatus.inactive,

      role: UserRole.fromString(json[ApiKeys.role] as String? ?? ''),
    );
  }
}
