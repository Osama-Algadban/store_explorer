import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:store_explorer/core/shared/exception/exception.dart';
import 'package:store_explorer/core/shared/failure/failure.dart';

extension ExceptionExtension on Exception {
  Failure toFailure({bool realtimeDbException = false}) {
    switch (runtimeType) {
      case const (AppException):
        final e = this as AppException;
        return _appExceptionToFailure(e);
      default:
        Logger().e(this);
        return Failure(message: toString(), title: 'error');
    }
  }
}

Failure _appExceptionToFailure(AppException e) {
  Logger().e({'Message': e.message ?? e.code.title, 'title': e.code.title});
  return Failure(
    message: e.message ?? e.code.message,
    title: e.code.title,
    widget: e.code.widget,
  );
}

extension ExceptionCodeExtension on ExceptionCode {
  String get message {
    switch (this) {
      case ExceptionCode.cacheManager:
      case ExceptionCode.unknown:
        return "Unknown error happened. Please try agin latter.";

      case ExceptionCode.apiManager:
      case ExceptionCode.unauthenticated:
        return "Your request is not completed duo to some issues";
    }
  }

  String get title {
    switch (this) {
      case ExceptionCode.unknown:
      case ExceptionCode.apiManager:
      case ExceptionCode.cacheManager:
      case ExceptionCode.unauthenticated:
        return "Error";
    }
  }

  Widget? get widget {
    switch (this) {
      case ExceptionCode.unknown:
      case ExceptionCode.apiManager:
      case ExceptionCode.cacheManager:
      case ExceptionCode.unauthenticated:
        return null;
    }
  }
}
