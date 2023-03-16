import 'http_client.dart';
import 'package:http/http.dart' as http;

class HttpClientImpl implements HttpClient {
  final client = http.Client();

  @override
  Future<HttpResponse> get(String url) async {
    final response = await client.get(Uri.parse(url));

    return HttpResponse(data: response.body, statusCode: response.statusCode);
  }
}
