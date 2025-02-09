abstract class Exception {}

//200 success but empty
class SuccessResponseEmptyException extends Exception {}

//202
class AcceptedButNotCompliedException extends Exception {}

//204
class EmptyResponseException extends Exception {}

//302
class UrlHasBeenChangedException extends Exception {}

//304
class ResponseHasNotChangedException extends Exception {}

//400
class ValidationErrorException extends Exception {}

//401
class UnauthorizedException extends Exception {}

//402
class PaymentRequiredException extends Exception {}

//403
class NotPermissionException extends Exception {}

//404
class NotFoundException extends Exception {}

//405
class MethodNotAllowedException extends Exception {}

//409
class AlreadyExistException extends Exception {}

//429/494
class TooManyRequestException extends Exception {}

//440
class LoginTimeOutException extends Exception {}

//444
class NoResponseException extends Exception {}

//498
class InvalidTokenException extends Exception {}

//500
class ServerErrorException extends Exception {}

//503
class UnableToHandleTheRequestException extends Exception {}

//504 The server did not receive a timely response from an upstream server
class GetWayTimeoutException extends Exception {}

//599
class NetWorkTimeOutException extends Exception {}

//check internet
class CheckConnectionException extends Exception {}

class DefaultException extends Exception {}
