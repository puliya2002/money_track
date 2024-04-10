import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SwitchProvider with ChangeNotifier {
  bool _isBusiness = false;

  bool get isBusiness => _isBusiness;

  void toggleSwitch(bool newValue) {
    _isBusiness = newValue;
    notifyListeners();
  }
}
