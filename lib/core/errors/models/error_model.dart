import 'package:sams_dashboard/core/utils/constants/api_keys.dart';

class ErrorModel {
  final String status;
  final String message;
  final dynamic data;
  ErrorModel({
    required this.status,
    required this.message,
    this.data,
  });

  factory ErrorModel.fromJson(Map<String, dynamic> json) {
    String? tempMessage = json[ApiKeys.message] as String?;

    if (json[ApiKeys.validationErrors] != null &&
        json[ApiKeys.validationErrors] is List) {
      tempMessage = (json[ApiKeys.validationErrors] as List).join('\n');
    }
    return ErrorModel(
      status: json[ApiKeys.status] as String? ?? 'fail',
      message: tempMessage ?? 'Something went wrong',
      data: json[ApiKeys.data],
    );
  }
}
