import 'package:sams_dashboard/core/utils/constants/api_keys.dart';

class UserPaginationModel {
  final int totalElements;
  final int currentPage;
  final int size;
  final int totalPages;
  final bool hasNextPage;
  final bool hasPrevPage;

  const UserPaginationModel({
    required this.totalElements,
    required this.currentPage,
    required this.size,
    required this.totalPages,
    required this.hasNextPage,
    required this.hasPrevPage,
  });

  factory UserPaginationModel.fromJson(Map<String, dynamic> json) {
    return UserPaginationModel(
      totalElements: (json[ApiKeys.totalElements] as num? ?? 0).toInt(),
      currentPage: (json[ApiKeys.currentPage] as num? ?? 1).toInt(),
      size: (json[ApiKeys.size] as num? ?? 10).toInt(),
      totalPages: (json[ApiKeys.totalPages] as num? ?? 1).toInt(),
      hasNextPage: json[ApiKeys.hasNextPage] as bool? ?? false,
      hasPrevPage: json[ApiKeys.hasPrevPage] as bool? ?? false,
    );
  }

  UserPaginationModel copyWith({
    int? totalElements,
    int? currentPage,
    int? size,
    int? totalPages,
    bool? hasNextPage,
    bool? hasPrevPage,
  }) {
    return UserPaginationModel(
      totalElements: totalElements ?? this.totalElements,
      currentPage: currentPage ?? this.currentPage,
      size: size ?? this.size,
      totalPages: totalPages ?? this.totalPages,
      hasNextPage: hasNextPage ?? this.hasNextPage,
      hasPrevPage: hasPrevPage ?? this.hasPrevPage,
    );
  }
}
