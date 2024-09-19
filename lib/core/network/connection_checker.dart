
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

abstract interface class ConnectionChecker {
  Future<bool> isConnected();
}

class ConnectionCheckerImpl extends ConnectionChecker {

  InternetConnection internetConnection;
  ConnectionCheckerImpl(this.internetConnection);

  @override
  Future<bool> isConnected() async {
    return await internetConnection.hasInternetAccess;
  }

}
