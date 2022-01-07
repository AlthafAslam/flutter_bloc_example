import 'package:jify_flutter_app/src/blocs/base_bloc.dart';
import 'package:jify_flutter_app/src/managers/object_factory.dart';
import 'package:jify_flutter_app/src/managers/state/response_state.dart';
import 'package:jify_flutter_app/src/models/image_search_response.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:rxdart/rxdart.dart';

class SearchBloc extends Object implements BaseBloc{
  final _screenStatus = BehaviorSubject<ScreenStatus>();
  final _imageList = BehaviorSubject<ImageSearchResponse>();

  ImageSearchResponse get getImageSearchResVal => _imageList.value;
  Stream<ImageSearchResponse> get getImageResStream => _imageList.stream;

  Future<void> searchImage({required String query}) async {
    if(ObjectFactory().networkManager.hasConnectivity) {
      changeScreenStatus(ScreenStatus.loading);
      ResponseState responseState = await ObjectFactory().repository.searchImage(query);
      changeScreenStatus(ScreenStatus.ready);
      if(responseState is SuccessResponseState<ImageSearchResponse>){
        _imageList.sink.add(responseState.value);
      } else if (responseState is ErrorResponseState) {
        _imageList.sink.addError('${responseState.msg}');
      }
    } else{
      changeScreenStatus(ScreenStatus.noInternet);
      toast('No Internet');
    }
  }


  @override
  Function(ScreenStatus) get changeScreenStatus => _screenStatus.sink.add;

  @override
  ScreenStatus get getScreenStatus => _screenStatus.value;

  @override
  Stream<ScreenStatus> get screenStatus => _screenStatus.stream;

  @override
  void dispose() async {
    await _screenStatus.drain();
    _screenStatus.close();
  }
}