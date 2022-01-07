import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';

class ApiClient {
  late Dio _dio;

  ApiClient() {
    initClient();
  }

  initClient() async{

    _dio = Dio(BaseOptions(
      baseUrl: 'https://pixabay.com/api/',
      connectTimeout: 30000, /// 30 Seconds
      receiveTimeout: 30000, ///30 Seconds
      headers: {
        Headers.contentTypeHeader: Headers.jsonContentType,
        Headers.acceptHeader: Headers.jsonContentType,
      },
      followRedirects: true,
      responseType: ResponseType.json,
      receiveDataWhenStatusError: true,
    ));
    _dio.interceptors.add(InterceptorsWrapper(
      onResponse: (Response<dynamic> response, ResponseInterceptorHandler responseInterceptorHandler) {
        // Do something with response data
        return responseInterceptorHandler.next(response); // continue
        // If you want to reject the request with a error message,
        // you can reject a `DioError` object eg: return `dio.reject(dioError)`
      },
      onRequest: (RequestOptions reqOptions, RequestInterceptorHandler requestInterceptorHandler) {
        // Do something before request is sent
        // ignore: unnecessary_brace_in_string_interps

        return requestInterceptorHandler.next(reqOptions); //continue
        // If you want to resolve the request with some custom data，
        // you can resolve a `Response` object eg: return `dio.resolve(response)`.
        // If you want to reject the request with a error message,
        // you can reject a `DioError` object eg: return `dio.reject(dioError)`
      },
      onError: (DioError dioError, ErrorInterceptorHandler errorInterceptorHandle) {
        // Do something with response error
        return errorInterceptorHandle.next(dioError); //continue
        // If you want to resolve the request with some custom data，
        // you can resolve a `Response` object eg: return `dio.resolve(response)`.
      },
    ));
    _dio.interceptors.add(CookieManager(CookieJar()));
  }

  Dio get dio => _dio;

  /// API Urls
  String apiKeySearchImageQ = '?key=25135493-5782e50dbd46403f65a83348b&q='; // Password login

}
