import 'dart:io';
import 'package:dio/dio.dart';
import '../enums/app_enums.dart';
import '../utils/logger.dart';

enum RequestType {
  post,
  get,
  put,
  patch,
  delete,
}

class ApiHandler {

  ApiHandler._();

  static Future<void> sendRequest({
    String baseUrl = "",
    required Dio dio,
    required String endPoint,
    required RequestType type,
    Map<String, dynamic>? params,
    FormData? formData,
    bool useFormData = true,
    Map<String, dynamic>? body,
    required void Function(Response response) onSuccess,
    required void Function(Response response) onError,
  }) async {
    final fullUrl = '$baseUrl$endPoint';
    logDebug('📡 API Request: $type $fullUrl \n🔹 Params: $params \n🔹 Headers: ${dio.options.headers}');

    Response response = Response(requestOptions: RequestOptions());

    try {
      switch (type) {
        case RequestType.get:
          response = await dio.get(fullUrl, queryParameters: params);
          break;
        case RequestType.post:
          response = await dio.post(fullUrl, queryParameters: params, data: useFormData ? formData : body);
          break;
        case RequestType.delete:
          response = await dio.delete(fullUrl, queryParameters: params);
          break;
        case RequestType.put:
          response = await dio.put(fullUrl, queryParameters: params, data: useFormData ? formData : body);
          break;
        default:
          throw UnsupportedError("RequestType $type is not supported");
      }

      logDebug('✅ API Success: $type $fullUrl \n🔹 Status: ${response.statusCode}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        onSuccess(response);
      } else {
        logDebug('⚠️ API Error: Non-success status ${response.statusCode}', level: Level.error);
        onError(response);
      }
    } on DioException catch (e) {
      response = e.response ?? Response(requestOptions: RequestOptions());
      logDebug(
        '❌ DioException: $type $fullUrl \n🔹 Status: ${response.statusCode} \n🔹 Error: ${e.message}',
        level: Level.error,
      );
      onError(response);
    } on IOException catch (e) {
      logDebug(
        '❌ Network Error: $type $fullUrl \n🔹 Exception: $e',
        level: Level.error,
      );
      onError(
        Response(
          requestOptions: RequestOptions(),
          statusCode: 408,
          statusMessage: 'Connection timeout',
        ),
      );
    } catch (e) {
      logDebug(
        '❌ Unexpected Error: $type $fullUrl \n🔹 Exception: $e',
        level: Level.error,
      );
      onError(response);
    }
  }
}
