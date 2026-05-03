import 'package:flutter/cupertino.dart';
import 'package:weather_web/data/models/My_Response_Models/forcastDay_model.dart';
import 'package:weather_web/data/repositories/weather_repo.dart';
import 'package:weather_web/utils/showFailureMsg.dart';

//forecast screen provider with dependency injection
class ForcastProvider with ChangeNotifier{

WeatherRepo repo;
List<Forecastday> forecastList=[];
bool isLoading=false;

//injection
ForcastProvider(this.repo){
  getForcast();
}

//get forecast screen data func.
Future<void> getForcast()async{

  try{
    isLoading=true;
    notifyListeners();
    forecastList= await repo.getForcast('Kamoke', 2);
    notifyListeners();
  }
  catch(e){
    showMsg(e.toString());
  }finally{
    isLoading=false;
    notifyListeners();
  }
}
}