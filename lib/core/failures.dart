import 'package:supabase_flutter/supabase_flutter.dart';

abstract class Failure {
  final String message;

  Failure(this.message);
}

class ServerFailure extends Failure {
  ServerFailure(super.message);
}

class CacheFailure extends Failure {
  CacheFailure(super.message);
}

class NetworkFailure extends Failure {
  NetworkFailure(super.message);
}

// if there is no specific exception, use this fucntion to get the failure
Failure getFailure(String message) {
  switch (message) {
    case 'server':
      return ServerFailure('Server Failure');
    case 'cache':
      return CacheFailure('Cache Failure');
    case 'network':
      return NetworkFailure('Network Failure');
    default:
      return ServerFailure(message);
  }
}

// you can specify the message of the exception
Failure getFailureFromException(Exception e) {
  if (e is StorageException) {
    return ServerFailure(e.toString());
  } else if (e is CacheException) {
    return CacheFailure(e.toString());
  } else {
    return ServerFailure('Server Failure ${e.toString()}');
  }
}

class CacheException implements Exception {
  String? message;
  CacheException([this.message]);

  @override
  String toString() {
    return message ?? 'Cache Exception';
  }
}
