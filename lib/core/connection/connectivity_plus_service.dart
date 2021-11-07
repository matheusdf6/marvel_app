import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:marvel_app/core/connection/connection_service.dart';

class ConnectivityPlusService implements ConnectionService {
  @override
  Future<bool> isConnected() async {
    final result = await Connectivity().checkConnectivity();
    return result != ConnectivityResult.none;
  }
}
