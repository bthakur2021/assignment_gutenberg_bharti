import 'dart:convert';

import 'package:dio/dio.dart';

import '../../utilities/print_util.dart';

class NetworkCallInterceptor extends Interceptor {

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    try {
      final requestedDataJson = json.encode(options.data);
      PrintUtils.printLog('URL: ${options.uri}');
      PrintUtils.printLog('requestedDataJson: $requestedDataJson');
    } catch (e) {
      PrintUtils.printLog('NetworkCallInterceptor: $e');
    }

    return handler.next(options);
  }

  @override
  void onResponse(Response<dynamic> response, ResponseInterceptorHandler handler) {
    return handler.next(response);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    return handler.next(err);
  }
}
