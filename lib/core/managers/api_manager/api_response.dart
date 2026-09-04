part of 'api_manager.dart';

class ApiResponse<T> extends Equatable {
  final bool success;
  final String? message;
  final T data;
  final int status;

  factory ApiResponse.fromString(String json, int status) {
    final jsonDecoding = jsonDecode(json);
    final successR = jsonDecoding["success"] ?? status <= 300 && status >= 200;
    final messageR = jsonDecoding["message"];
    final bodyR = jsonDecoding["data"];
    if (bodyR is T) {
      return ApiResponse<T>(
        success: successR,
        message: messageR,
        data: bodyR,
        status: status,
      );
    } else {
      throw AppException(code: ExceptionCode.unknown);
    }
  }

  factory ApiResponse.fromDioResponse(Response response) {
    final data = response.data;
    final message = response.statusMessage;
    final status = response.statusCode ?? 0;
    final tempStatus = response.statusCode ?? 0;
    final isSuccess = tempStatus >= 200 && tempStatus <= 300;
    return ApiResponse(
      success: isSuccess,
      message: message,
      data: data ?? emptyBody(),
      status: status,
    );
  }

  const ApiResponse({
    required this.success,
    required this.message,
    required this.data,
    required this.status,
  });

  @override
  List<Object?> get props => [success, message, data];
}
