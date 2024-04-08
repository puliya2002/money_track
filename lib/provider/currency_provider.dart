import 'package:flutter/material.dart';

class CurrencyProvider extends ChangeNotifier {
  late String _selectedCurrency;

  CurrencyProvider() {
    // Set default currency
    _selectedCurrency = "LKR ";
  }

  String get selectedCurrency => _selectedCurrency;

  void setCurrency(String currency) {
    _selectedCurrency = currency;
    notifyListeners();
  }
}