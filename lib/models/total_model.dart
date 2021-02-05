import 'package:flutter/material.dart';

class TotalModel extends ChangeNotifier {
  int _total = 0;
  int get total => _total;

void reset() {
    _total = 0;
    notifyListeners();
  }

  void increment() {
    _total++;
    notifyListeners();
  }
}
