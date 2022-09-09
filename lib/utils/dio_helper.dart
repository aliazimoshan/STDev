import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:stdev/constant/token.dart';
import 'package:stdev/constant/urls.dart';

class DioHelper {
  static Future post(
    String url, {
    var body,
  }) async {
    try {
      var dio = Dio();
      Response response;
      var headers = {'x-apikey': TOKEN};
      response = await dio.post(
        url,
        data: body,
        options: Options(
          headers: headers,
        ),
      );

      return response;
    } catch (e) {
      throw Exception(e);
    }
  }

  static Future get(String url) async {
    try {
      var dio = Dio();
      Response response;
      var headers = {'x-apikey': TOKEN};
      response = await dio.get(
        url,
        options: Options(
          headers: headers,
        ),
      );

      return response;
    } catch (e) {
      throw Exception(e);
    }
  }

  static Future delete(
    String url, {
    var body,
  }) async {
    try {
      var dio = Dio();
      Response response;
      var headers = {'x-apikey': TOKEN};
      response = await dio.delete(
        url,
        data: body,
        options: Options(
          headers: headers,
        ),
      );

      return response;
    } catch (e) {
      throw Exception(e);
    }
  }
}
