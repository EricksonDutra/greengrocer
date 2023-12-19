import 'package:dio/dio.dart';

class HttpManager {
  Future<Map> restRequest({
    required String url,
    required String method,
    Map? headers,
    Map? body,
  }) async {
    //Headers da requisição
    final defaultHeaders = headers?.cast<String, String>() ?? {}
      ..addAll({
        'content-type': 'application/json',
        'accept': 'application/json',
        'X-Parse-Application-Id': 'wK7GcEjr2V4br5q5mlR1kybQ5dvxMFDX0qtE1d6Y',
        'X-Parse-REST-API-Key': '2kahi62fkWePLWAwC7k8aMrtQkobogcgkruMxbeB',
      });

    Dio dio = Dio();

    try {
      var response = await dio.request(
        url,
        options: Options(
          method: method,
          headers: defaultHeaders,
        ),
        data: body,
      );

      //retorno do resultado do backend
      return response.data;
    } on DioException catch (e) {
      //retorno do erro do dio request
      return e.response?.data ?? {};
    } catch (e) {
      //retorno de map vazio - erro geral
      return {};
    }
  }
}

abstract class HttpMethods {
  static const String post = 'POST';
  static const String get = 'GET';
  static const String put = 'PUT';
  static const String delete = 'DELETE';
  static const String patch = 'PATCH';
}
