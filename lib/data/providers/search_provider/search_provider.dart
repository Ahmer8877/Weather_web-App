import 'package:flutter/cupertino.dart';
import 'package:weather_web/data/models/My_Response_Models/Search_model.dart';
import 'package:weather_web/data/repositories/weather_repo.dart';
import 'package:weather_web/utils/showFailureMsg.dart';

//search screen provider with dependency injection
class SearchProvider with ChangeNotifier{

  WeatherRepo repo;
  List<search_model>items=[];
  bool isLoading=false;

  //injection
  SearchProvider(this.repo);

  Future<void> getSearchRieger(String city)async{
    try{
      isLoading=true;
      notifyListeners();
      items=await repo.getSearchRigeon(city);
      notifyListeners();
    }catch(e){
      showMsg(e.toString());
    }finally{
      isLoading=false;
      notifyListeners();
    }
  }
}