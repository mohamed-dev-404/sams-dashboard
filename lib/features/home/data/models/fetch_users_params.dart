import 'package:sams_dashboard/core/utils/constants/api_keys.dart';

class FetchUsersParams {
  final int page;
  final int size;
  final String? roleId;
  final String? sortBy;
  final String? sortOrder;
  final String? search;
  final String? status;

  FetchUsersParams({
    this.page = 1,
    this.size = 10,
    this.roleId,
    this.sortBy = ApiValues.createdAt,
    this.sortOrder = ApiValues.desc,
    this.search,
    this.status,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      ApiKeys.page: page,
      ApiKeys.size: size,
      ApiKeys.sortBy: sortBy,
      ApiKeys.sortOrder: sortOrder,
    };

    if (roleId != null && roleId!.isNotEmpty) data[ApiKeys.roleId] = roleId;
    if (search != null && search!.isNotEmpty) data[ApiKeys.search] = search;
    if (status != null && status!.isNotEmpty) data[ApiKeys.status] = status;

    return data;
  }
}
