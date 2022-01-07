import 'package:jify_flutter_app/src/managers/state/response_state.dart';
import 'package:jify_flutter_app/src/providers/image_search_api_provider.dart';

class Repository{
  final ImageSearchApiProvider _searchApiProvider = ImageSearchApiProvider();

  Future<ResponseState> searchImage(String searchQuery) => _searchApiProvider.searchImage(searchQuery);
}