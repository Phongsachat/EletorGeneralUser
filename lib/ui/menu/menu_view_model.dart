import 'dart:developer';

import 'package:Eletor/widgets/constants.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class MenuViewModel extends BaseViewModel{
  int _indexSegmentSelected = 0;
  PageController _pageController = PageController(initialPage: 0,keepPage: true);

  int get indexSegmentSelected => _indexSegmentSelected;
  var _menuIndex = 0;

  bool _isPageLoading = false;


  bool get isPageLoading => _isPageLoading;

  ///Widget State
  Color _menuHomeColor = secondColor;
  Color _menuCameraColor = Colors.white;
  Color _menuMissionColor = Colors.white;

  MenuViewModel() {
    initState();
    notifyListeners();
  }

  initState() {
    _pageController = PageController(initialPage: 0);
    _indexSegmentSelected = 0;
    _isPageLoading = false;
    notifyListeners();
  }

  showLoading() {
    log("showLoading Active", name: 'showLoading');
    _isPageLoading = true;
    notifyListeners();
    _isPageLoading = false;
  }

  dismissLoading() {
    log("dismissLoading Active", name: 'dismissLoading');
    _isPageLoading = false;
    notifyListeners();
  }



  changePage(int index,{bool animate = true}) async {
    if (animate) {
      await _pageController.animateToPage(index,
          duration: Duration(milliseconds: 200), curve: Curves.decelerate);
    }
    _indexSegmentSelected = index;

  }

  setMenuIndex(int currentMenuIndex) {
    log("setIndex from $_menuIndex to $currentMenuIndex");
    _menuIndex = currentMenuIndex;

    if (currentMenuIndex == 0) {
      _menuHomeColor = secondColor;
      _menuCameraColor = Colors.white;
      _menuMissionColor = Colors.white;
    } else if (currentMenuIndex == 1) {
      _menuHomeColor = Colors.white;
      _menuCameraColor = secondColor;
      _menuMissionColor = Colors.white;
    } else if (currentMenuIndex == 2) {
      _menuHomeColor = Colors.white;
      _menuCameraColor = Colors.white;
      _menuMissionColor = secondColor;
    }

    notifyListeners();
  }

  bool _homeState = true;

  get homeState => _homeState;

  changeHomeState(bool homeState){
    _homeState = homeState;
    notifyListeners();
  }

  get menuIndex => _menuIndex;

  Color get menuHomeColor => _menuHomeColor;

  Color get menuCameraColor => _menuCameraColor;

  Color get menuMissionColor => _menuMissionColor;

  PageController get pageController => _pageController;
}