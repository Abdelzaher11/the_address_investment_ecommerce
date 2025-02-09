import 'package:dio/dio.dart';

import '../../errors/error_handler.dart';
import '../url/url.dart';

class DioConnection {
  final Dio _dio = Dio();

   Future<Response?> post(
    String endPoint, {
    Map<String, dynamic>? queryParameter,
    Map<String, dynamic>? data,
    Options? options,
  }) async {
    Response? response;
    try {
      response = await _dio.post(
        '${Url.baseUrl}$endPoint',
        queryParameters: queryParameter,
        data: data,
      );
    } catch (exception) {
      ErrorHandler.check(exception: exception);
    }
    return response;
  }

  Future<Response?> get(String endPoint,
      {Map<String, dynamic>? queryParameter, Map<String, dynamic>? data, String? url, Options? options}) async {
    Response? response;
    try {
      response = await _dio.get(
        '${url ?? Url.baseUrl}$endPoint',
        queryParameters: queryParameter,
        data: data,
      );
    } catch (exception) {
      ErrorHandler.check(exception: exception);
    }
    return response;
  }

  Future<Response?> put(String endPoint,
      {Map<String, dynamic>? queryParameter, Map<String, dynamic>? data, String? url, Options? options}) async {
    Response? response;
    try {
      response = await _dio.put(
      '${url ?? Url.baseUrl}$endPoint',
        queryParameters: queryParameter,
        data: data,
      );
    } catch (exception) {
      ErrorHandler.check(exception: exception);
    }
    return response;
  }

 }


