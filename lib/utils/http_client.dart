import 'package:dio/dio.dart';

// Facade

class HttpClient {
  Dio _dio;
  final String baseUrl;

  Dio get http => _dio;

  HttpClient({this.baseUrl}) {
    this._dio = _client(baseUrl);
  }

  Dio _client(String baseUrl) {
    BaseOptions options = new BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: 10000,
        receiveTimeout: 10000,
        contentType: 'application/json');

    return Dio(options);
  }
}

extension Methods on HttpClient {
  Future<dynamic> get(String path) async {
    try {
      return await this.http.get(path);
    } on DioError catch (e) {
      return e;
    }
  }
}

class HttpResponse<T> {
  HttpResponse(
      {this.data,
      this.statusCode,
      this.statusMessage,
      this.errorMessage,
      this.errorType});

  T data;
  int statusCode;
  String statusMessage;
  DioErrorType errorType;
  String errorMessage;
}
