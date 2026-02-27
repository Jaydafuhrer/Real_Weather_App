//class ServerException implements Exception {}
//class CacheException implements Exception {}
class ServerException implements Exception {
  final String message;

  // Optional message with default fallback
  ServerException({this.message = 'Server Failure'});

  @override
  String toString() => message;
}

class CacheException implements Exception {}
