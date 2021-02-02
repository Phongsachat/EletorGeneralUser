import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:connectivity/connectivity.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:flutter/material.dart';
import 'package:overlay_support/overlay_support.dart';

class ConnectionViewModel extends ChangeNotifier {
  static bool _isConnected = true;
  Key _notificationKey = UniqueKey();

  Connectivity connectivity = Connectivity();
  StreamSubscription<DataConnectionStatus> _subscription;
  StreamController controller = StreamController.broadcast();

  Key get notificationKey => _notificationKey;

  connectionChecker() {
    init();
  }

  init() {
    checkInternetConnectivity();
    notifyListeners();
  }

  isConnectedValue() {
    isConnected;
    notifyListeners();
  }

  dispose() {
    super.dispose();
    try {
      _subscription.cancel();
    } catch (error) {}
  }

  void checkInternetConnectivity() async {
    ConnectivityResult result = await connectivity.checkConnectivity();
    _checkStatus(result);
    connectivity.onConnectivityChanged.listen((result) {
      _checkStatus(result);
    });
  }

  void _checkStatus(ConnectivityResult result) async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        log('data connection status SUCCESS');
        _isConnected = true;
        showSimpleNotification(Text("เชื่อมต่ออินเทอร์เน็ตแล้ว!"),
            duration: Duration(seconds: 2),
            background: Colors.green,
            key: _notificationKey);
      } else {
        log('data connection status FAILED');
        _isConnected = false;
        showSimpleNotification(
          Text("กรุณาตรวจสอบสัญญาณอินเทอร์เน็ต!"),
          key: _notificationKey,
          autoDismiss: _isConnected,
          background: Colors.red,
        );
      }

      notifyListeners();
    } on SocketException catch (_) {
      _isConnected = false;
      log('data connection status ERROR');
      showSimpleNotification(
        Text("กรุณาตรวจสอบสัญญาณอินเทอร์เน็ต!"),
        key: _notificationKey,
        autoDismiss: _isConnected,
        background: Colors.red,
      );
      notifyListeners();
    }
    controller.sink.add({result: isConnected});
  }

  void disposeStream() => controller.close();

  bool get isConnected => _isConnected;

  // StreamSubscription<ConnectivityResult> get subscription => _subscription;
  StreamSubscription<DataConnectionStatus> get subscription => _subscription;
}