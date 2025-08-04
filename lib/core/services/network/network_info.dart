import 'package:connectivity_plus/connectivity_plus.dart';

abstract class NetworkInfo {
  Future<bool> get isConnected;
  Stream<List<ConnectivityResult>> get onConnectivityChanged;
  bool isOnline(List<ConnectivityResult> connectivityResults);
}

class NetworkInfoImpl implements NetworkInfo {
  final Connectivity connectivity;

  NetworkInfoImpl(this.connectivity);

  @override
  Future<bool> get isConnected async {
    final result = await connectivity.checkConnectivity();
    return isOnline(result);
  }

  @override
  Stream<List<ConnectivityResult>> get onConnectivityChanged async* {
    yield* connectivity.onConnectivityChanged;
  }

  @override
  bool isOnline(List<ConnectivityResult> connectivityResults) {
    return connectivityResults.contains(ConnectivityResult.wifi) ||
        connectivityResults.contains(ConnectivityResult.mobile) ||
        connectivityResults.contains(ConnectivityResult.ethernet);
  }
}
