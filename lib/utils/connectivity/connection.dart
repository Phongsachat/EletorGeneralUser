import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:flutter/material.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:stacked/stacked.dart';

class ConnectionViewModel extends BaseViewModel {
  static bool _isConnected = true;
  Connectivity _connectivity;
  Key _notificationKey = UniqueKey();

  // StreamSubscription<ConnectivityResult> _subscription;
  StreamSubscription<DataConnectionStatus> _subscription;

  Key get notificationKey => _notificationKey;

  connectionChecker() {
    init();
  }

  init() {
    checkInternetConnectivity();
    notifyListeners();
  }

  dispose() {
    super.dispose();
    try{
      _subscription.cancel();
    }catch (error){}
  }

  // ignore: missing_return
  Future<bool> checkInternetConnectivity() async {
    // print("The statement 'this machine is connected to the Internet' is: ");
    // print(await DataConnectionChecker().hasConnection);
    // print("Current status: ${await DataConnectionChecker().connectionStatus}");
    // print("Last results: ${DataConnectionChecker().lastTryResults}");
    _subscription = DataConnectionChecker().onStatusChange.listen((status) {
      switch (status) {
        case DataConnectionStatus.connected:
          {
            _isConnected = true;
            print('Data connection is available.');
            showSimpleNotification(Text("เชื่อมต่ออินเทอร์เน็ตแล้ว!"),
                duration: Duration(seconds: 2),
                background: Colors.green,
                key: _notificationKey);
          }
          break;
        case DataConnectionStatus.disconnected:
          {
            _isConnected = false;
            print('Data connection is disconnected.');
            showSimpleNotification(
              Text("กรุณาตรวจสอบสัญญาณอินเทอร์เน็ต!"),
              key: _notificationKey,
              autoDismiss: _isConnected,
              background: Colors.red,
            );
          }
          break;
      }
      notifyListeners();
    });

    // _connectivity = new Connectivity();
    // _subscription =
    //     connectivity.onConnectivityChanged.listen((ConnectivityResult result) {
    //   print(result.toString());
    //   if (result == ConnectivityResult.wifi ||
    //       result == ConnectivityResult.mobile) {
    //     showSimpleNotification(Text("Connected!"),
    //         duration: Duration(seconds: 2), background: Colors.green);
    //     log(result.toString());
    //     _isConnected = true;
    //   } else {
    //     showSimpleNotification(Text("Lost Connection!"),
    //         background: Colors.red);
    //     _isConnected = false;
    //   }
    //   notifyListeners();
    // });
  }

  // checkInternet() async {
  // Simple check to see if we have internet
  // print("The statement 'this machine is connected to the Internet' is: ");
  // print(await DataConnectionChecker().hasConnection);
  // returns a bool

  // We can also get an enum value instead of a bool
  // print("Current status: ${await DataConnectionChecker().connectionStatus}");
  // prints either DataConnectionStatus.connected
  // or DataConnectionStatus.disconnected

  // This returns the last results from the last call
  // to either hasConnection or connectionStatus
  // print("Last results: ${DataConnectionChecker().lastTryResults}");

  // actively listen for status updates
  // this will cause DataConnectionChecker to check periodically
  // with the interval specified in DataConnectionChecker().checkInterval
  // until listener.cancel() is called
  // var listener = DataConnectionChecker().onStatusChange.listen((status) {
  //   switch (status) {
  //     case DataConnectionStatus.connected:
  //       print('Data connection is available.');
  //       break;
  //     case DataConnectionStatus.disconnected:
  //       print('You are disconnected from the internet.');
  //       break;
  //   }
  // });

  // close listener after 30 seconds, so the program doesn't run forever
  // await Future.delayed(Duration(seconds: 30));
  // await listener.cancel();
  // }

  bool get isConnected => _isConnected;

  Connectivity get connectivity => _connectivity;

  // StreamSubscription<ConnectivityResult> get subscription => _subscription;
  StreamSubscription<DataConnectionStatus> get subscription => _subscription;
}
