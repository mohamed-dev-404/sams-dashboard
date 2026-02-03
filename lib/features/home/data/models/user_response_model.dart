import 'user_model.dart';
import 'user_pagination_model.dart';

class UserResponseModel {
  final String status;
  final List<UserModel> users;
  final UserPaginationModel pagination;

  UserResponseModel({
    required this.status,
    required this.users,
    required this.pagination,
  });

  factory UserResponseModel.fromJson(Map<String, dynamic> json) {
    return UserResponseModel(
      status: json['status'] as String,
      users: (json['data'] as List)
          .map((item) => UserModel.fromJson(item as Map<String, dynamic>))
          .toList(),
      pagination: UserPaginationModel.fromJson(json['pagination']),
    );
  }
}
