class CustomException implements Exception{

  String message;
  String prefix;

  CustomException([this.prefix,this.message]);

  @override
  String toString() {
    // TODO: implement toString
    return '$prefix: $message';
  }
}

class ResourceNotFoundException extends CustomException{

  ResourceNotFoundException([String message]):super(message,'Resource not found');
}

class UnauthorizedException extends CustomException{

  UnauthorizedException([String message]):super(message,'Unauthorized');
}

class BadRequestException extends CustomException{

  BadRequestException([String message]):super(message,'Bad Request');
}

class FetchDataException extends CustomException{

  FetchDataException([String message]):super(message,'Exception during fetching response');
}

class ServerException extends CustomException{

  ServerException([String message]):super(message,'Internal Server Exception');
}