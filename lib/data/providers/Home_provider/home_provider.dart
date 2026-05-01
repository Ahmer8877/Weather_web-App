import 'package:flutter/widgets.dart';
import 'package:weather_web/data/models/My_Response_Models/condition_model.dart';
import 'package:weather_web/data/models/My_Response_Models/locattion_model.dart';
import 'package:weather_web/data/models/currentWeather_model/currentWeather_model.dart';
import 'package:weather_web/data/repositories/weather_repo.dart';
import 'package:weather_web/utils/showFailureMsg.dart';

class  HomeProvider with ChangeNotifier{

  WeatherRepo repo;
  Location_model? location;
  CurrentModel? current;
  bool isLoading=false;

  HomeProvider(this.repo){
    getCurrentWeather('Kamoke');
  }

  Future<void> getCurrentWeather(String city)async{

    try{
      isLoading=true;
      CurrentweatherModel? res=await repo.getCurrentWeather(city);
      if(res!=null){
        location=res.location;
        current=res.current;
        notifyListeners();
      }
    }catch(e){
      showMsg(e.toString());
    }finally{
      isLoading=false;
      notifyListeners();
    }
  }
}