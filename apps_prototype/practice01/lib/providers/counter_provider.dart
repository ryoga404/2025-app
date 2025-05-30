import 'package:flutter/material.dart';

class CounterProvider with ChangeNotifier {
  int _counter = 0;

  int get counter => _counter;

  void increment() {
    _counter++;
    notifyListeners();  // 状態が変わったことを通知
  }

  void decrement() {
    if(_counter > 0) {
      _counter--;
      notifyListeners();  // 状態が変わったことを通知
    }

  }



}
