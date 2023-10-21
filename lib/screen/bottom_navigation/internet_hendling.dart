import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class NetworkStatusPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final networkStatus = Provider.of<NetworkStatusProvider>(context).status;

    return Scaffold(
      appBar: AppBar(
        title: Text('Network Status'),
      ),
      body: Center(
        child: networkStatus == NetworkStatus.connected
            ? Text('Connected to the Internet')
            : Text('Disconnected from the Internet'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Provider.of<NetworkStatusProvider>(context, listen: false)
              .checkStatus();
        },
        child: Icon(Icons.refresh),
      ),
    );
  }
}






enum NetworkStatus { connected, disconnected }

class NetworkStatusProvider extends ChangeNotifier {
  NetworkStatus _status = NetworkStatus.connected;

  NetworkStatus get status => _status;

  Future<void> checkStatus() async {
    var connectivityResult = await (Connectivity().checkConnectivity());

    if (connectivityResult == ConnectivityResult.none) {
      _status = NetworkStatus.disconnected;
    } else {
      _status = NetworkStatus.connected;
    }

    notifyListeners();
  }
}
