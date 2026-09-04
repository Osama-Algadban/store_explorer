
import 'package:equatable/equatable.dart';

part 'exception_code.dart';

class AppException extends Equatable implements Exception {
  const AppException({
    required this.code,
    this.message,
    this.stackTrace,
  });

  final ExceptionCode code;
  final String? message;
  final StackTrace? stackTrace;

  AppException copyWith({
    ExceptionCode? code,
    String? message,
    StackTrace? stackTrace,
  }) {
    return AppException(
      code: code ?? this.code,
      message: message ?? this.message,
      stackTrace: stackTrace ?? this.stackTrace,
    );
  }

  factory AppException.unknown({String? message, StackTrace? stackTrace}) =>
      AppException(
          code: ExceptionCode.unknown,
          message: message,
          stackTrace: stackTrace);

  @override
  List<Object?> get props => [code, message];

  @override
  String toString() {
    return 'AppException(code: $code, message: $message, stackTrace: $stackTrace)';
  }
}
