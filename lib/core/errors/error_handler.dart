import 'package:dio/dio.dart';
import 'package:the_address_investments_ecommerce/core/errors/exception.dart';
import 'package:the_address_investments_ecommerce/core/errors/failure.dart';

class ErrorHandler {
  static String? responseMessage;
  static Response? responseValue;
  ErrorHandler.check({required dynamic exception}) {
    if (exception is DioException) {
      throw _handleDioException(exception);
    }
  }

  ErrorHandler.checkStatusCode(Response response) {
    responseMessage = responseMessageFunc(response);
    if (response.statusCode == 202) {
      throw AcceptedButNotCompliedException();
    } else if (response.statusCode == 204) {
      throw EmptyResponseException();
    } else if (response.statusCode == 302) {
      throw UrlHasBeenChangedException();
    } else if (response.statusCode == 304) {
      throw ResponseHasNotChangedException();
    } else if (response.statusCode == 400) {
      throw ValidationErrorException();
    } else if (response.statusCode == 401) {
      throw UnauthorizedException();
    } else if (response.statusCode == 402) {
      throw PaymentRequiredException();
    } else if (response.statusCode == 403) {
      throw NotPermissionException();
    } else if (response.statusCode == 404) {
      throw NotFoundException();
    } else if (response.statusCode == 405) {
      throw MethodNotAllowedException();
    } else if (response.statusCode == 409) {
      throw AlreadyExistException();
    } else if (response.statusCode == 494 || response.statusCode == 429) {
      throw TooManyRequestException();
    } else if (response.statusCode == 440) {
      throw LoginTimeOutException();
    } else if (response.statusCode == 444) {
      throw NoResponseException();
    } else if (response.statusCode == 498) {
      throw InvalidTokenException();
    } else if (response.statusCode == 500) {
      throw ServerErrorException();
    } else if (response.statusCode == 503) {
      throw UnableToHandleTheRequestException();
    } else if (response.statusCode == 504) {
      throw GetWayTimeoutException();
    } else if (response.statusCode == 599) {
      throw NetWorkTimeOutException();
    } else {
      throw DefaultException();
    }
  }

  static Exception _handleDioException(
    DioException exception,
  ) {
    switch (exception.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        throw CheckConnectionException();
      case DioExceptionType.badResponse:
        throw ErrorHandler.checkStatusCode(exception.response!);
      default:
        throw ServerErrorException();
    }
  }

  String? responseMessageFunc(Response? response) {
    String? errorMessage;
    responseValue = response;
    final data = response?.data as Map<String, dynamic>;
    data.forEach(
      (key, value) {
        if (value.runtimeType == String) {
          errorMessage = value;
        } else {
          value != null
              ? errorMessage = value['message']
              : errorMessage = value['detail']['message'];
        }
      },
    );
    return errorMessage;
  }

  //Call All Exceptions

  static Failure handleException(Exception e) {
    if (e is AlreadyExistException) {
      return (AlreadyExistFailure(ErrorHandler.responseMessage));
    } else if (e is UnableToHandleTheRequestException) {
      return UnableToHandleTheRequestFailure(ErrorHandler.responseMessage);
    } else if (e is GetWayTimeoutException) {
      return GetWayTimeoutFailure(ErrorHandler.responseMessage);
    } else if (e is SuccessResponseEmptyException) {
      return SuccessResponseEmptyFailure(null);
    } else if (e is EmptyResponseException) {
      return EmptyResponseFailure(ErrorHandler.responseMessage);
    } else if (e is ResponseHasNotChangedException) {
      return ResponseHasNotChangedFailure(ErrorHandler.responseMessage);
    } else if (e is PaymentRequiredException) {
      return PaymentRequiredFailure(ErrorHandler.responseMessage);
    } else if (e is UrlHasBeenChangedException) {
      return UrlHasBeenChangedFailure(ErrorHandler.responseMessage);
    } else if (e is ValidationErrorException) {
      return (ValidationErrorFailure(ErrorHandler.responseMessage));
    } else if (e is UnauthorizedException) {
      return (UnauthorizedFailure(ErrorHandler.responseMessage));
    } else if (e is MethodNotAllowedException) {
      return (MethodNotAllowedFailure(ErrorHandler.responseMessage));
    } else if (e is TooManyRequestException) {
      return (TooManyRequestFailure(ErrorHandler.responseMessage));
    } else if (e is NotFoundException) {
      return (NotFoundFailure(ErrorHandler.responseMessage));
    } else if (e is NotPermissionException) {
      return (NotPermissionFailure(ErrorHandler.responseMessage));
    } else if (e is LoginTimeOutException) {
      return (LoginTimeOutFailure(ErrorHandler.responseMessage));
    } else if (e is NoResponseException) {
      return (NoResponseFailure(ErrorHandler.responseMessage));
    } else if (e is InvalidTokenException) {
      return (InvalidTokenFailure(ErrorHandler.responseMessage));
    } else if (e is ServerErrorException) {
      return (ServerErrorFailure(ErrorHandler.responseMessage));
    } else if (e is NetWorkTimeOutException) {
      return (NetWorkTimeOutFailure(ErrorHandler.responseMessage));
    } else if (e is CheckConnectionException) {
      return (CheckConnectionFailure(ErrorHandler.responseMessage));
    } else if (e is DefaultException) {
      return (DefaultFailure(null));
    } else if (e is AcceptedButNotCompliedException) {
      return (AcceptedButNotCompliedFailure(ErrorHandler.responseMessage));
    } else {
      return (DefaultFailure("Unknown error occurred"));
    }
  }
}