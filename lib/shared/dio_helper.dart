import 'dart:io';

import 'package:dio/dio.dart';
import 'package:green_bin/const/end_points.dart';

class DioHelper {
  static late Dio dio;

  static init() {
    dio = Dio(
      BaseOptions(
        baseUrl: 'https://www.graduation.se3dawy.com/api/v1',
        responseType: ResponseType.json,
        contentType: ContentType.json.toString(),
        receiveDataWhenStatusError: true,
      ),
    );
  }

  static Future<Response> postData({
    required String url,
    Map<String, dynamic>? data,
    Map<String, dynamic>? query,
    String? token,
    //  String lang = 'en',
  }) async {
    dio.options.headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer     $token',
    };
    return await dio.post(
      url,
      data: data,
      queryParameters: query,
    );
  }

  static Future<Response> getData({
    required String url,
    Map<String, dynamic>? query,
    String? token,
  }) async {
    dio.options.headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };
    return await dio.get(
      url,
      queryParameters: query,
    );
  }
}
