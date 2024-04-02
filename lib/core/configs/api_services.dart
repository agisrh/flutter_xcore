// ignore_for_file: constant_identifier_names

import 'package:dio/dio.dart';
import 'package:flutter_xcore/developer_logs.dart';
import 'connectivity_status.dart';

enum MethodRequest { POST, GET, PUT, DELETE }

class ApiService {
  final Dio _dio = Dio();

  ApiService(String baseUrl) {
    _dio.options.baseUrl = baseUrl;
    _dio.options.connectTimeout = 90000; //90s
    _dio.options.receiveTimeout = 50000;
    _dio.options.headers = {
      'Accept': 'application/json',
    };
    _dio.options.receiveDataWhenStatusError = true;
  }

  Future<Response> call(String url,
      {MethodRequest method = MethodRequest.POST,
      dynamic request,
      Map<String, String>? header,
      String? token,
      bool useFormData = false}) async {
    bool isOnline = await ConnectivityService.hasNetwork();
    if (isOnline != true) {
      Response response = Response(
        data: {
          "message": "Tidak terhubung ke jaringan",
        },
        statusCode: 00,
        requestOptions: RequestOptions(path: ''),
      );
      return response;
    }
    if (header != null) {
      _dio.options.headers = header;
    }
    if (token != null) {
      if (header != null) {
        header.addAll({'Authorization': token});
        _dio.options.headers = header;
      } else {
        _dio.options.headers = {
          'Accept': 'application/json',
          'Authorization': token,
        };
      }
      // if (method == MethodRequest.PUT) {
      //   _dio.options.headers = {
      //     'Accept': 'application/json',
      //     'Content-Type': 'application/x-www-form-urlencoded',
      //     'Authorization': 'Bearer $token',
      //   };
      // }
    }

    logSuccess('URL : ${_dio.options.baseUrl}$url');
    logSuccess('Method : $method');
    logSuccess("Header : ${_dio.options.headers}");
    logSuccess("Request : $request");

    MethodRequest? selectedMethod;
    try {
      Response response;
      switch (method) {
        case MethodRequest.GET:
          selectedMethod = method;
          response = await _dio.get(url, queryParameters: request);
          break;
        case MethodRequest.PUT:
          selectedMethod = method;
          response = await _dio.put(
            url,
            data: useFormData ? FormData.fromMap(request!) : request,
          );
          break;
        case MethodRequest.DELETE:
          selectedMethod = method;
          response = await _dio.delete(
            url,
            data: useFormData ? FormData.fromMap(request!) : request,
          );
          break;
        default:
          selectedMethod = MethodRequest.POST;
          response = await _dio.post(
            url,
            data: useFormData ? FormData.fromMap(request!) : request,
          );
      }
      logSuccess(
          'Success $selectedMethod $url: \nResponse : ${url.contains("rss") ? "rss feed response to long" : response.data}');
      return response;
    } on DioError catch (e) {
      logError('Error $selectedMethod $url: $e\nData: ${e.response?.data}');
      if (e.response?.data is Map) {
        if (!(e.response?.data as Map).containsKey("message")) {
          (e.response?.data as Map).addAll(<String, dynamic>{
            "message":
                "Terjadi kesalahan, silahkan coba dalam beberapa saat lagi.",
          });
        }

        return e.response!;
      } else {
        Response response = Response(
          data: {
            "message":
                "Terjadi kesalahan, silahkan coba dalam beberapa saat lagi.",
          },
          requestOptions: e.requestOptions,
          statusCode: e.response?.statusCode,
        );
        return response;
      }
    }
  }
}
