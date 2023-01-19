import 'package:flutter/material.dart';

class CartState with ChangeNotifier {
  int _quantity = 0;

  int get getQuantity => _quantity;

  void addCart() {
    _quantity++;
    notifyListeners();
  }
}
