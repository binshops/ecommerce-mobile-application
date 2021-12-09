import 'package:flutter/material.dart';

class BottomNavigation extends ChangeNotifier{
  var _counter = 0;

  int get counter => _counter;
  void setCounter(int i){
    _counter = i;
    notifyListeners();
  }
}