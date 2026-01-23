import 'package:dio/dio.dart';

class ApiClient{
  late final Dio dio;

  ApiClient() {
    dio = Dio(
      BaseOptions(
        baseUrl: 'https://api-on-anime.vercel.app/anime',
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
        headers: {
          'Accept': 'application/json',
        }
      )
    );

    dio.interceptors.add(
      LogInterceptor(requestBody: true, responseBody: true)
    );
  }
}