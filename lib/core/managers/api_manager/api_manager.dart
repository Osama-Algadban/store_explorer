import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:store_explorer/core/managers/api_manager/api_constant.dart';
import 'package:store_explorer/core/shared/exception/exception.dart';

import 'api_helper.dart';

part 'api_enums.dart';
part 'api_request.dart';
part 'routes.dart';
part 'api_response.dart';

abstract class ApiManager {
  Future<ApiResponse<T>> request<T>(ApiRequest request);
  void config();
}

@Singleton(as: ApiManager)
class ApiManagerImpl implements ApiManager {
  late final Dio dio;

  @override
  Future<ApiResponse<T>> request<T>(ApiRequest request) async {
    try {
      final Response response;
      switch (request.requestType) {
        case RequestType.get:
          response = await dio.get(
            request.url,
            options: Options(headers: request.header),
            data: request.body,
          );
        case RequestType.post:
          response = await dio.post(
            request.url,
            options: Options(headers: request.header),
            queryParameters: request.body,
            data: request.formData,
          );
        case RequestType.delete:
          response = await dio.delete(
            request.url,
            options: Options(headers: request.header),
            queryParameters: request.body,
          );
        case RequestType.put:
          response = await dio.put(
            request.url,
            options: Options(headers: request.header),
            queryParameters: request.body,
          );
        case RequestType.patch:
          response = await dio.patch(
            request.url,
            options: Options(headers: request.header),
            queryParameters: request.body,
          );
      }

      if (request.autoConvert) {
        return ApiResponse<T>.fromString(
          jsonEncode(response.data ?? ""),
          response.statusCode ?? 500,
        );
      } else {
        return ApiResponse<T>.fromDioResponse(response);
      }
    } on DioException catch (e) {
      final responseData = e.response?.data;
      String? serverMessage;

      if (responseData is Map) {
        serverMessage = responseData["message"];

        if (responseData.containsKey("errors") && responseData["errors"] is Map) {
          final errors = responseData["errors"] as Map;
          if (errors.isNotEmpty) {
            final firstErrorList = errors.values.first;
            if (firstErrorList is List && firstErrorList.isNotEmpty) {
              serverMessage = firstErrorList.first.toString();
            }
          }
        }
      }

      if (e.response?.statusCode == 401) {
        throw AppException(
          code: ExceptionCode.unauthenticated,
          message: serverMessage ?? "Your request is not completed duo to some issues.",
        );
      }

      throw AppException(
        code: ExceptionCode.apiManager,
        message: serverMessage ?? "exceptions your Request Is Not Completed",
      );

    } catch (e) {
      throw AppException(
        code: ExceptionCode.apiManager,
        message: "Your request is not completed duo to some issues.",
      );
    }
  }

  @override
  void config() {
    dio = Dio();
    dio.options.baseUrl = ApiRoutes.baseUrlDev;
    dio.httpClientAdapter = IOHttpClientAdapter(
      createHttpClient: () {
        final client = HttpClient();
        client.badCertificateCallback = (X509Certificate cert, String host, int port) => true;
        return client;
      },
    );
    dio.options.headers = {
      ...ApiConstants.baseHeader,
    };

    dio.interceptors.add(
      PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        request: true,
        compact: true,
      ),
    );
  }
}