import 'package:flutter/material.dart';

import 'package:dio/dio.dart';

enum HttpMethod {
  get, post
}

class HttpService {
  late Dio _dio;

  HttpService({required String host})  {
    _dio = Dio(BaseOptions(
        baseUrl: host,
        connectTimeout: 10000,
        receiveTimeout: 10000
    ));

    initializeInterceptors();
  }

  Future<Response?> request(HttpMethod method, {
    required String path,
    Map<String, dynamic>? params,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? data,
  }) async {
    Response? response;
    try{
      switch (method) {
        case HttpMethod.get:
          response = await _dio.get(path, queryParameters: params, options: Options(
            headers: headers,
          ));
          break;
        case HttpMethod.post:
          response = await _dio.post(path, queryParameters: params, data: data, options: Options(
            headers: headers,
          ));
          break;
      }
    } on DioError catch (e) {
      debugPrint(e.message);
      throw Exception(e.message);
    }
    return response;
  }

  initializeInterceptors() {
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          debugPrint("header:${options.headers} method:${options.method} path:${options.path}");
          return handler.next(options);
        },
        onResponse: (response, handler) {
          return handler.next(response);
        },
        onError: (DioError e, handler) {
          return handler.next(e);
        },
      ),
    );
  }
}