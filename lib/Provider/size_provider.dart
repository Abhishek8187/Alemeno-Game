import 'package:flutter/material.dart';

class SizeIncrease with ChangeNotifier{

  int _size = 0;
  int get size => _size;

  void increaseSize(){
    _size = _size+30;
    notifyListeners();
  }
}