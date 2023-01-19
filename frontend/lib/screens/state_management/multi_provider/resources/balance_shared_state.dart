import 'package:flutter/material.dart';

class BalanceState with ChangeNotifier {
  int _balance = 150000;

  int get getBalance {
    return _balance;
  }

  void decreaseBalance(int cost) {
    _balance -= cost;
    notifyListeners();
  }
}
