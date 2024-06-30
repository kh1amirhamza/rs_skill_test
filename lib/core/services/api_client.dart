abstract class APIClient {
  Future<dynamic> get(String endpoint, {Map<String, dynamic>? queryParameters});
  Future<dynamic> post(String endpoint, {required String data});
  Future<dynamic> delete(String endpoint);
  Future<dynamic> uploadFiles(String endpoint,
      {Map<String, dynamic>? data, Map<String, dynamic>? keysAndFilePaths});
}
