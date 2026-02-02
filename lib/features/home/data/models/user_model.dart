import 'package:sams_dashboard/features/home/data/enum/user_role.dart';
import 'package:sams_dashboard/features/home/data/enum/user_status.dart';

class UserModel {
  final String id;
  final String name;
  final String email;
  UserStatus status;
  UserRole role;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.status,
    required this.role,
  });
}
