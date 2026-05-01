import 'package:flutter/widgets.dart';

class IndexProvider with ChangeNotifier{

  int currentIndex=0;

  set index(int index){
    currentIndex=index;
    notifyListeners();
  }
}