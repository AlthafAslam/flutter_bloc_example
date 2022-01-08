import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:jify_flutter_app/src/managers/state/response_state.dart';
import 'package:overlay_support/overlay_support.dart';

enum NetworkStatus {  Online, Offline }

class NetworkManager {
  StreamController<NetworkStatus> networkStatusController =
  StreamController<NetworkStatus>();

   late NetworkStatus _networkStatus;
   late Connectivity _connectivity;

  NetworkManager() {
    _connectivity = Connectivity();
    _connectivity.checkConnectivity().then((ConnectivityResult value) {
      _networkStatus = _getNetworkStatus(value);
    });
  }

  Future<Connectivity> init() async {
    _connectivity.onConnectivityChanged.listen((status) {
      _networkStatus = _getNetworkStatus(status);
      networkStatusController.add(_networkStatus);
      if (_networkStatus == NetworkStatus.Offline) {
        showOverlay((context, t) {
          return Container(
            color: Color.lerp(Colors.transparent, Colors.black54, t),
            child: FractionalTranslation(
              translation: const Offset(0.5,1),
              child: AlertDialog(
                title: const Text('No internet!'),
                content: const Text(
                    'You\'re not connected to Internet. Please check your connectivity.'),
                actions: <Widget>[
                  TextButton(
                    child: const Text("OKAY"),
                    onPressed: () {
                      OverlaySupportEntry.of(context)!.dismiss();
                    },
                  )
                ],
              ),
            ),
          );
        }, key: const Key('noInternet'), duration: Duration.zero);
      }
    });

    return _connectivity;
  }

  Future<Connectivity> get connectivity async {
    if (_connectivity != null) return _connectivity;
    _connectivity = await init();
    return _connectivity;
  }

  NetworkStatus _getNetworkStatus(ConnectivityResult status) {
    return status == ConnectivityResult.mobile ||
        status == ConnectivityResult.wifi
        ? NetworkStatus.Online
        : NetworkStatus.Offline;
  }

  bool get hasConnectivity => _networkStatus == NetworkStatus.Online;

  static serverErrorHandler({Response<dynamic>? response}) {
    return ResponseState<dynamic>.error('${response!.statusMessage}');
  }
}
