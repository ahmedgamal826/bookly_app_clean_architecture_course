import 'package:dio/dio.dart';

abstract class Failure {}

class ServerFailure extends Failure {
  final String message;
  ServerFailure({required this.message});

  factory ServerFailure.fromDioError(DioError dioError) {
    switch (dioError.type) {
      case DioExceptionType.connectionTimeout:
        return ServerFailure(message: 'Connection timeout');
      case DioExceptionType.sendTimeout:
        return ServerFailure(message: 'Send timeout');
      case DioExceptionType.receiveTimeout:
        return ServerFailure(message: 'Receive timeout');
      case DioExceptionType.badCertificate:
        return ServerFailure(message: 'Bad certificate');
      case DioExceptionType.badResponse:
      case DioExceptionType.cancel:
        return ServerFailure(message: 'Cancel');
      case DioExceptionType.connectionError:
        return ServerFailure(message: 'Connection error');
      case DioExceptionType.unknown:
        return ServerFailure(message: 'Unknown error, please try again later');
    }
  }

  factory ServerFailure.fromResponse(int statusCode, dynamic response) {
    if (statusCode == 400 || statusCode == 401 || statusCode == 403) {
      return ServerFailure(message: response['error']['message']);
    } else if (statusCode == 404) {
      return ServerFailure(message: 'Your request not found, please try again later');
    } else if (statusCode == 500) {
      return ServerFailure(message: 'Internal server error, please try again later');
    } else {
      return ServerFailure(message: 'Unexpected error, please try again later');
    }
  }
}
