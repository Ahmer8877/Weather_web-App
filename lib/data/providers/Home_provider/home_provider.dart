import 'package:flutter/widgets.dart';
import 'package:weather_web/data/models/My_Response_Models/condition_model.dart';
import 'package:weather_web/data/models/My_Response_Models/locattion_model.dart';
import 'package:weather_web/data/models/currentWeather_model/currentWeather_model.dart';
import 'package:weather_web/data/repositories/weather_repo.dart';
import 'package:weather_web/utils/showFailureMsg.dart';

//home screen provider with dependency injection
class  HomeProvider with ChangeNotifier{

  WeatherRepo repo;
  Location_model? location;
  CurrentModel? current;
  bool isLoading=false;

  //injection
  HomeProvider(this.repo){
    getCurrentWeather('Kamoke');
  }

  // get current wather func. use get current weather
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