import 'package:store_explorer/core/shared/exception/exception.dart';
T emptyBody<T>() {
  if (T is String) {
    return "" as T;
  } else if (T is int) {
    return 0 as T;
  } else if (T is double) {
    return 0.0 as T;
  } else if (T is List<dynamic>) {
    return [] as T;
  } else if (T is Map<dynamic, dynamic>) {
    return {} as T;
  } else {
    throw AppException(code: ExceptionCode.unknown);
  }
}
