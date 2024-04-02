import 'dart:io';

// enum ConnectivityStatus { WiFi, Cellular, Offline }

class ConnectivityService {
  // static ConnectivityStatus connectionStatus = ConnectivityStatus.Offline;

  static Future<bool> hasNetwork() async {
    try {
      final result = await InternetAddress.lookup('example.com');
      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } on SocketException catch (_) {
      return false;
    }
  }

  // static init() async {
  //   connectionStatus = _connectionStatus(await Connectivity().checkConnectivity());
  //   Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
  //     connectionStatus = _connectionStatus(result);
  //   });
  // }

  // /// Convert from the third part enum to our own enum
  // static ConnectivityStatus _connectionStatus(ConnectivityResult result) {
  //   switch (result) {
  //     case ConnectivityResult.mobile:
  //       return ConnectivityStatus.Cellular;
  //     case ConnectivityResult.wifi:
  //       return ConnectivityStatus.WiFi;
  //     case ConnectivityResult.none:
  //       return ConnectivityStatus.Offline;
  //   }
  // }
}
