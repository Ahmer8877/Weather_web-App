import 'package:flutter/widgets.dart';

//current index class provider
class IndexProvider with ChangeNotifier{

  int currentIndex=0;

  //set func.
  set index(int index){
    currentIndex=index;
    notifyListeners();
  }
}