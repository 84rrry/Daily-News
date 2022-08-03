import 'package:dio/dio.dart';

// https://newsapi.org/
// v2/top-headlines?
// country=us&category=business&apiKey=5bbe1c636fcb40dda9a05aef876bbdaa
class DioHelper {
  static late Dio dio;
  static init() {
    dio = Dio(
      BaseOptions(
        baseUrl: 'https://newsapi.org/',
        receiveDataWhenStatusError: true,
      ),
    );
  }

  static Future<Response> getData({
    required String url,
    required Map<String, dynamic> query,
  }) async {
    return await dio.get(
      url,
      queryParameters: query,
    );
  }
}
