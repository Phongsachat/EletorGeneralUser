import 'dart:developer';

import 'package:flutter/cupertino.dart';

class LoadingViewModel extends ChangeNotifier {
  bool _isPageLoading = false;
  bool _isGoogleMapLoading = false;
  bool _isAcceptMissionLoading = false;

  bool get isPageLoading => _isPageLoading;

  bool get isGoogleMapLoading => _isGoogleMapLoading;

  bool get isAcceptMissionLoading => _isAcceptMissionLoading;

  LoadingViewModel() {
    init();
    notifyListeners();
  }

  init() {}

  showLoading() {
    log("showLoading Active", name: 'showLoading');
    _isPageLoading = true;
    log("_isPageLoading = $isPageLoading");
    notifyListeners();
  }

  dismissLoading() {
    log("dismissLoading Active", name: 'dismissLoading');
    _isPageLoading = false;
    log("_isPageLoading = $isPageLoading");
    notifyListeners();
  }

  showGoogleMapLoading() {
    _isGoogleMapLoading = true;
    notifyListeners();
  }

  dismissGoogleMapLoading() {
    _isGoogleMapLoading = false;
    notifyListeners();
  }

  showAcceptMissionLoading() {
    _isAcceptMissionLoading = true;
    notifyListeners();
  }

  dismissAcceptMissionLoading() {
    _isAcceptMissionLoading = false;
    notifyListeners();
  }
}
