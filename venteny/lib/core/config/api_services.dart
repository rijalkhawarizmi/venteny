import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class ApiServices extends Interceptor {
  static final Dio _dio = Dio(BaseOptions(baseUrl: "https://reqres.in"));

  static final ApiServices _instance = ApiServices._internal();

  factory ApiServices() {
    return _instance;
  }

  ApiServices._internal() {
    _dio.interceptors.add(PrettyDioLogger(
        requestHeader: true,
        request: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        error: true,
        compact: true,
        maxWidth: 300));
    _dio.options.connectTimeout =
        const Duration(seconds: 30); // 30 detik timeout
    _dio.options.receiveTimeout =
        const Duration(seconds: 30); // 30 detik timeout
    _dio.interceptors.add(this);
  }

  Future<Response> postRequest({
    String? path,
    Map<String, dynamic>? rawJson,
    FormData? formData,
    Options? options,
  }) async {
    try {
      options ??= Options();
      options.headers = options.headers ?? {};
      options.headers!["Content-Type"] = "application/json";

      Response response = await _dio.post(
        path ?? "",
        data: formData ?? rawJson,
        options: options,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> getRequest(
      {String? path, Map<String, dynamic>? rawJson, FormData? formData}) async {
    print('40111');
    try {
      Response response = await _dio.get(path ?? "", data: rawJson ?? formData);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> putRequest(
      {String? path, Map<String, dynamic>? rawJson, FormData? formData}) async {
    try {
      Response response = await _dio.put(path ?? "", data: rawJson ?? formData);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> patchRequest(
      {String? path, Map<String, dynamic>? rawJson, FormData? formData}) async {
    try {
      Response response =
          await _dio.patch(path ?? "", data: rawJson ?? formData);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> deleteRequest(
      {String? path, Map<String, dynamic>? rawJson, FormData? formData}) async {
    try {
      Response response =
          await _dio.delete(path ?? "", data: rawJson ?? formData);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    // get token from the storage

    return super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    return super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    // Check if the user is unauthorized.

    // Retry the request.
    try {} on DioException catch (e) {
      // If the request fails again, pass the error to the next interceptor in the chain.
      handler.next(e);
    }
    // Return to prevent the next interceptor in the chain from being executed.
    handler.next(err);

    // Pass the error to the next interceptor in the chain.
  }
}
