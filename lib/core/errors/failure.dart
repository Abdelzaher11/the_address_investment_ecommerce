abstract class Failure {
  Failure(this.message);
  String message;
}

class DefaultFailure extends Failure {
  DefaultFailure(String? message) : super(message ?? 'something went wrong');
}

class SuccessResponseEmptyFailure extends Failure {
  SuccessResponseEmptyFailure(String? message) : super(message ?? 'Empty');
}

//202
class AcceptedButNotCompliedFailure extends Failure {
  AcceptedButNotCompliedFailure(String? message)
      : super(message ?? 'AcceptedButNotCompliedFailure');
}

//204
class EmptyResponseFailure extends Failure {
  EmptyResponseFailure(String? message)
      : super(message ?? 'EmptyResponseFailure');
}

//302
class UrlHasBeenChangedFailure extends Failure {
  UrlHasBeenChangedFailure(String? message)
      : super(message ?? 'UrlHasBeenChangedFailure');
}

//304
class ResponseHasNotChangedFailure extends Failure {
  ResponseHasNotChangedFailure(String? message)
      : super(message ?? 'ResponseHasNotChangedFailure');
}

//400
class ValidationErrorFailure extends Failure {
  ValidationErrorFailure(String? message)
      : super(message ?? 'Validation Error');
}

//401
class UnauthorizedFailure extends Failure {
  UnauthorizedFailure(String? message) : super(message ?? 'Unauthorized Error');
}

//402
class PaymentRequiredFailure extends Failure {
  PaymentRequiredFailure(String? message)
      : super(message ?? 'PaymentRequiredFailure');
}

//403
class NotPermissionFailure extends Failure {
  NotPermissionFailure(String? message) : super(message ?? 'Not Permission');
}

//404
class NotFoundFailure extends Failure {
  NotFoundFailure(String? message) : super(message ?? 'Not Found');
}

//405
class MethodNotAllowedFailure extends Failure {
  MethodNotAllowedFailure(String? message)
      : super(message ?? 'MethodNotAllowedFailure');
}

//409
class AlreadyExistFailure extends Failure {
  AlreadyExistFailure(String? message) : super(message ?? 'Already Exist');
}

//429/494
class TooManyRequestFailure extends Failure {
  TooManyRequestFailure(String? message) : super(message ?? 'TooMany Request');
}

//440
class LoginTimeOutFailure extends Failure {
  LoginTimeOutFailure(String? message) : super(message ?? 'Login Time Out');
}

//444
class NoResponseFailure extends Failure {
  NoResponseFailure(String? message) : super(message ?? 'No Response');
}

//498
class InvalidTokenFailure extends Failure {
  InvalidTokenFailure(String? message) : super(message ?? 'Invalid Token');
}

//500
class ServerErrorFailure extends Failure {
  ServerErrorFailure(String? message) : super(message ?? 'Server Error');
}

//503
class UnableToHandleTheRequestFailure extends Failure {
  UnableToHandleTheRequestFailure(String? message)
      : super(message ?? 'UnableToHandleTheRequestFailure');
}

//504
class GetWayTimeoutFailure extends Failure {
  GetWayTimeoutFailure(String? message)
      : super(message ?? 'GetWayTimeoutFailure');
}

//599
class NetWorkTimeOutFailure extends Failure {
  NetWorkTimeOutFailure(String? message) : super(message ?? 'NetWork Time Out');
}

class CheckConnectionFailure extends Failure {
  CheckConnectionFailure(String? message)
      : super(message ?? "");
}
