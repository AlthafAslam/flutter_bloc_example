import 'package:jify_flutter_app/src/managers/api/api_client.dart';

class ApiService {
  late ApiClient _client;

  ApiService() {
    _client = ApiClient();
  }

  ///Search image
  Future<dynamic> passwordLogin(String searchQuery) {
    return _client.dio.get(Uri.encodeFull(_client.apiKeySearchImageQ + searchQuery + '&image_type=photo'));
  }
}
