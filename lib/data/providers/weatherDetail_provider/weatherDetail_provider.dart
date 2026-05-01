import 'package:flutter/cupertino.dart';
import 'package:weather_web/data/models/My_Response_Models/condition_model.dart';
import 'package:weather_web/data/models/My_Response_Models/locattion_model.dart';
import 'package:weather_web/data/repositories/weather_repo.dart';

import '../../../utils/showFailureMsg.dart';
import '../../models/currentWeather_model/currentWeather_model.dart';

class WeatherdetailProvider with ChangeNotifier{

  WeatherRepo repo;
  Location_model? location;
  CurrentModel? current;
  bool isLoading=false;

  WeatherdetailProvider(this.repo);

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