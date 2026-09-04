part of 'api_manager.dart';

class ApiRequest extends Equatable {
  final Map<String, dynamic>? header;
  final Map<String, dynamic>? body;
  final RequestType requestType;
  final String url;

  final bool autoConvert;
  final FormData? formData;

  const ApiRequest({
    this.header,
    this.body,
    this.formData,
    this.autoConvert = true,
    required this.requestType,
    required this.url,
  });



  @override
  List<Object?> get props => [header, body, requestType, url];
}
