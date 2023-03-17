abstract class HttpClient {
  Future<HttpResponse> get(String url);
}

class HttpResponse {
  final dynamic data;
  final dynamic bodyBytes;
  final int? statusCode;

  HttpResponse({
    required this.data,
    required this.statusCode,
    this.bodyBytes,
  });
}
