import 'package:flutter/material.dart';

class GameController extends ChangeNotifier {
  String word = "";
  bool lineDone= false;
 void setCorrectWord(String s){
    word = s;
 }
@override
  void notifyListeners() {
    super.notifyListeners();
  }

  void lineCompleted(){
   lineDone = true;
  }

}

