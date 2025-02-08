import 'package:flutter/cupertino.dart';

class LayoutProvider extends ChangeNotifier{
  int selectedIndex=0;
  void changeBtnNavIndex(int value){
      selectedIndex=value;
      notifyListeners();
  }
}