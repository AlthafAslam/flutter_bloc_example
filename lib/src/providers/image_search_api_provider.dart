import 'package:dio/dio.dart';
import 'package:jify_flutter_app/src/managers/object_factory.dart';
import 'package:jify_flutter_app/src/managers/state/response_state.dart';
import 'package:jify_flutter_app/src/models/image_search_response.dart';

class ImageSearchApiProvider {
  Future<ResponseState> searchImage(String searchQuery) async {
    final Response<dynamic> response = await ObjectFactory().apiService.passwordLogin(searchQuery);

    if(response.statusCode == 200) {
      return ResponseState<ImageSearchResponse>.success(ImageSearchResponse.fromJson(response.data));
    } else {
      return ResponseState<dynamic>.error(ImageSearchResponse.fromJson(response.data));
    }
  }
}
