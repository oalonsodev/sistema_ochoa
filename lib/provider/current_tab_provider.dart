import 'package:flutter/material.dart';

class CurrentTabProvider with ChangeNotifier {
  int _currentTab = 0;

  get currentTab {
    return _currentTab;
  }

  set currentTab(int index) {
    _currentTab = index;

    notifyListeners();
  }
}
