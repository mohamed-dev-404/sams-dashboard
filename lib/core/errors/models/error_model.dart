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
    String tempMessage = '';

    //! 1. Handle validation errors (list of messages)
    if (json[ApiKeys.validationErrors] != null &&
        json[ApiKeys.validationErrors] is List) {
      final List<dynamic> errors = json[ApiKeys.validationErrors];
      tempMessage = errors.join('\n');
    }
    //! 2. Handle single error message (String)
    else if (json[ApiKeys.message] != null) {
      tempMessage = json[ApiKeys.message].toString();
    }
    //! 3. Fallback if no error message exists
    else {
      tempMessage = 'Unexpected error occurred';
    }

    return ErrorModel(
      status: json[ApiKeys.status]?.toString() ?? 'fail',
      message: tempMessage,
      data: json[ApiKeys.data],
    );
  }
}
