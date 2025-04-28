// Define an interceptor that logs the requests and responses
import 'dart:convert';

import 'package:dio/dio.dart';

import '../enums/app_enums.dart';
import '../utils/logger.dart';

class HttpLoggerInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    final options = err.requestOptions;
    final requestPath = '${options.baseUrl}${options.path}';

    // Log the error request and error message
    logDebug('onError: ${options.method} request => $requestPath', level: Level.error);
    logDebug('onError: ${err.error}, Message: ${err.message}', level: Level.debug);

    // Call the super class to continue handling the error
    return super.onError(err, handler);
  }

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    final requestPath = '${options.baseUrl}${options.path}';

    // Log request details
    logDebug('\n\n\n\n.........................................................................');
    logDebug('onRequest: ${options.method} request => $requestPath', level: Level.info);
    logDebug('onRequest: Request Headers => ${options.headers}', level: Level.info);

    if (options.data is FormData) {
      for (var data in (options.data as FormData).fields) {
        logDebug('onRequest: Request Data => ${data.key} -> ${data.value} ');
      }
      logDebug('onRequest: Request Data => ${_prettyJsonEncode(options.data)}', level: Level.info);
    } // Log formatted request dat
    // if(options.data is FormData){
    //   for(var data in options.data)
    //   {
    //     logDebug('Request Data => $data',
    //
    //         level: Level.info);
    //   }
    // }
    // Call the super class to continue handling the request
    return super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    // Log the response status code and data
    logDebug('API => ${response.realUri.toString()}', level: Level.debug);
    logDebug('onResponse: StatusCode: ${response.statusCode}, Data: ${_prettyJsonEncode(response.data)}',
        level: Level.debug); // Log formatted response data
    logDebug('.........................................................................\n\n\n\n');

    // Call the super class to continue handling the response
    return super.onResponse(response, handler);
  }

  // Helper method to convert data to pretty JSON format
  String _prettyJsonEncode(dynamic data) {
    try {
      var encoder = JsonEncoder.withIndent('  ');
      final jsonString = encoder.convert(data);
      return jsonString;
    } catch (e) {
      return data.toString();
    }
  }
}