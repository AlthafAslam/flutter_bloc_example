import 'package:jify_flutter_app/src/repository/repository.dart';

import 'api/api_service.dart';
import 'network/network_manager.dart';

class ObjectFactory {
  static final _objectFactory = ObjectFactory._internal();

  ObjectFactory._internal();

  factory ObjectFactory() => _objectFactory;

  ///Initialization of Objects
  ApiService _apiService = ApiService();
  NetworkManager _networkManager = NetworkManager();
  Repository _repository = Repository();

  ///
  /// Getter of Objects
  ///

  ApiService get apiService => _apiService;

  NetworkManager get networkManager => _networkManager;

  Repository get repository => _repository;

  ///
  /// Setter of Objects
  ///

}
