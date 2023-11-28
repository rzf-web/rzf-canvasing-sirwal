import 'package:dio/dio.dart';
import 'package:rzf_canvasing_sirwal/services/api/api_helper.dart';

class ApiService {
  static final _dio = Dio();

  static get(String url, {Map<String, dynamic>? queryParameters}) async {
    try {
      var response = await _dio.get(
        url,
        queryParameters: queryParameters,
        options: Options(headers: getHeader()),
      );
      return response;
    } on DioException catch (e) {
      return e;
    }
  }

  static post(String url, {Object? data}) async {
    try {
      var response = await _dio.post(
        url,
        data: data,
        options: Options(
          headers: getHeader(),
          contentType: Headers.formUrlEncodedContentType,
        ),
      );
      return response;
    } on DioException catch (e) {
      return e;
    }
  }

  static put(String url, {Object? data}) async {
    try {
      var response = await _dio.put(
        url,
        data: data,
        options: Options(headers: getHeader()),
      );
      return response;
    } on DioException catch (e) {
      return e;
    }
  }

  static delete(String url, {Object? data}) async {
    try {
      var response = await _dio.delete(
        url,
        data: data,
        options: Options(
          headers: getHeader(),
          contentType: Headers.formUrlEncodedContentType,
        ),
      );
      return response;
    } on DioException catch (e) {
      return e;
    }
  }
}
