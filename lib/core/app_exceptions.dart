class AppException implements Exception {

  final _message;
  final _prefix;
  AppException([this._message,this._prefix]);

  @override
  String toString() {
    // TODO: implement toString
    return '$_prefix$_message';
   // return super.toString();
  }
}

class FetchDataException extends AppException {
  FetchDataException([String? message]) : super(message, 'Error During Communication');
}

class BadRequestException extends AppException {
  BadRequestException([String? message]) : super(message, 'Invalid Request');
}

class UnauthorisedException extends AppException {
  UnauthorisedException([String? message]) : super(message, 'Unauthorised Request');
}

class InvalidInputException extends AppException {
  InvalidInputException([String? message]) : super(message, 'Invalid Input');
}