

// import 'package:equatable/equatable.dart';

// enum ServerExceptionType {
//   requestCancelled,

//   badCertificate,

//   unauthorisedRequest,

//   connectionError,

//   badRequest,

//   notFound,

//   requestTimeout,

//   sendTimeout,

//   recieveTimeout,

//   conflict,

//   internalServerError,

//   notImplemented,

//   serviceUnavailable,

//   socketException,

//   formatException,

//   unableToProcess,

//   defaultError,

//   unexpectedError,
// }

// class ApiException extends Equatable implements Exception{
//   const ApiException({this.message="Terjadi Kesalahan",this.error=""});

//   final String message;
//   final String error;
  
//   @override
//   // TODO: implement props
//   List<Object?> get props => [message,error];




// }


import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

enum ServerExceptionType {
  requestCancelled,

  badCertificate,

  unauthorisedRequest,

  connectionError,

  badRequest,

  notFound,

  requestTimeout,

  sendTimeout,

  recieveTimeout,

  conflict,

  internalServerError,

  notImplemented,

  serviceUnavailable,

  SocketException,

  formatException,

  unableToProcess,

  defaultError,

  unexpectedError,
}

class ApiException extends Equatable implements Exception {
  final String name, message;
  final int? statusCode;
  final ServerExceptionType exceptionType;

  ApiException._({
    required this.message,
    this.exceptionType = ServerExceptionType.unexpectedError,
    int? statusCode,
  })  : statusCode = statusCode ?? 500,
        name = exceptionType.name;

  factory ApiException(dynamic error) {
    late ApiException serverException;
    try {
      if (error is DioException) {
        switch (error.type) {
          case DioExceptionType.cancel:
            serverException = ApiException._(
                exceptionType: ServerExceptionType.requestCancelled,
                statusCode: error.response?.statusCode,
                message: 'Request to the server has been canceled');
            break;

          case DioExceptionType.connectionTimeout:
            serverException = ApiException._(
                exceptionType: ServerExceptionType.requestTimeout,
                statusCode: error.response?.statusCode,
                message: 'Connection timeout');
            break;

          case DioExceptionType.receiveTimeout:
            serverException = ApiException._(
                exceptionType: ServerExceptionType.recieveTimeout,
                statusCode: error.response?.statusCode,
                message: 'Receive timeout');
            break;

          case DioExceptionType.sendTimeout:
            serverException = ApiException._(
                exceptionType: ServerExceptionType.sendTimeout,
                statusCode: error.response?.statusCode,
                message: 'Send timeout');
            break;

          case DioExceptionType.connectionError:
            serverException = ApiException._(
                exceptionType: ServerExceptionType.connectionError,
                message: 'Koneksi bermasalah');
            break;
          case DioExceptionType.badCertificate:
            serverException = ApiException._(
                exceptionType: ServerExceptionType.badCertificate,
                message: 'Bad certificate');
            break;
          case DioExceptionType.unknown:
            if (error.error
                .toString()
                .contains(ServerExceptionType.SocketException.name)) {
              serverException = ApiException._(
                  statusCode: error.response?.statusCode,
                  message: 'Verify your internet connection');
            } else {
              serverException = ApiException._(
                  exceptionType: ServerExceptionType.unexpectedError,
                  statusCode: error.response?.statusCode,
                  message: 'Unexpected error');
            }
            break;

          case DioExceptionType.badResponse:
            switch (error.response?.statusCode) {
              case 400:
                serverException = ApiException._(
                    exceptionType: ServerExceptionType.badRequest,
                    message: error.response?.data["message"]);
                break;
              case 401:
                serverException = ApiException._(
                    exceptionType: ServerExceptionType.unauthorisedRequest,
                    message: 'Authentication failure');
                break;
              case 403:
                serverException = ApiException._(
                    exceptionType: ServerExceptionType.unauthorisedRequest,
                    message: 'User is not authorized to access API');
                break;
              case 404:
                serverException = ApiException._(
                    exceptionType: ServerExceptionType.notFound,
                    message: 'Request ressource does not exist');
                break;
              case 405:
                serverException = ApiException._(
                    exceptionType: ServerExceptionType.unauthorisedRequest,
                    message: 'Operation not allowed');
                break;
              case 415:
                serverException = ApiException._(
                    exceptionType: ServerExceptionType.notImplemented,
                    message: 'Media type unsupported');
                break;
              case 422:
                serverException = ApiException._(
                    exceptionType: ServerExceptionType.unableToProcess,
                    message: 'validation data failure');
                break;
              case 429:
                serverException = ApiException._(
                    exceptionType: ServerExceptionType.conflict,
                    message: 'too much requests');
                break;
              case 500:
                serverException = ApiException._(
                    exceptionType: ServerExceptionType.internalServerError,
                    message: 'Internal server error');
                break;
              case 503:
                serverException = ApiException._(
                    exceptionType: ServerExceptionType.serviceUnavailable,
                    message: 'Service unavailable');
                break;
              default:
                serverException = ApiException._(
                    exceptionType: ServerExceptionType.unexpectedError,
                    message: 'Unexpected error');
            }
            break;
        }
      } else {
        serverException = ApiException._(
            exceptionType: ServerExceptionType.unexpectedError,
            message: 'Unexpected error');
      }
    } on FormatException catch (e) {
      serverException = ApiException._(
          exceptionType: ServerExceptionType.formatException,
          message: e.message);
    } on Exception catch (_) {
      serverException = ApiException._(
          exceptionType: ServerExceptionType.unexpectedError,
          message: 'Unexpected error');
    }
    return serverException;
  }

  @override
  List<Object?> get props => [name, statusCode, exceptionType];
}