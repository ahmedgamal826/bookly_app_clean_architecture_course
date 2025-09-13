import 'package:dio/dio.dart';

class ApiServices {
  final Dio dio;
  final  baseUrl = 'https://www.googleapis.com/books/v1';
  

  ApiServices(this.dio);

  Future<Map<String, dynamic>> get(String endpoint) async {
    final response = await dio.get('$baseUrl$endpoint');
    return response.data;
  }
}
