import 'package:flutter/cupertino.dart';
import 'package:weather_web/data/models/My_Response_Models/forcastDay_model.dart';
import 'package:weather_web/data/repositories/weather_repo.dart';
import 'package:weather_web/utils/showFailureMsg.dart';

class ForcastProvider with ChangeNotifier{

WeatherRepo repo;
List<Forecastday> forecastList=[];
bool isLoading=false;

ForcastProvider(this.repo){
  getForcast();
}

Future<void> getForcast()async{

  try{
    isLoading=true;
    notifyListeners();
    forecastList= await repo.getForcast('Kamoke', 2);
  }
  catch(e){
    showMsg(e.toString());
  }finally{
    isLoading=false;
    notifyListeners();
  }
}
}