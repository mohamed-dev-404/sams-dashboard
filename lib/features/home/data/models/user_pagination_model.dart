class UserPaginationModel {
  final int totalElements;
  final int currentPage;
  final int totalPages;
  final bool hasNextPage;

  UserPaginationModel({
    required this.totalElements,
    required this.currentPage,
    required this.totalPages,
    required this.hasNextPage,
  });

  factory UserPaginationModel.fromJson(Map<String, dynamic> json) {
    return UserPaginationModel(
      totalElements: json['totalElements'] ?? 0,
      currentPage: json['currentPage'] ?? 1,
      totalPages: json['totalPages'] ?? 1,
      hasNextPage: json['hasNextPage'] ?? false,
    );
  }
}
