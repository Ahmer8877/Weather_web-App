import 'package:weather_web/data/models/My_Response_Models/Search_model.dart';
import 'package:weather_web/data/models/My_Response_Models/forcastDay_model.dart';
import 'package:weather_web/data/models/currentWeather_model/currentWeather_model.dart';
import 'package:weather_web/data/source_api/weather_Api.dart';

// Weather screen repository class with injection
class WeatherRepo {

  //injection
  WeatherApi api;

  WeatherRepo(this.api);

  //current city weather repo

  Future<CurrentweatherModel?> getCurrentWeather(String city)async{
    CurrentweatherModel? response=await api.getCurrentWeather(city);
    return response;
  }

   //forecast days city weather repo

  Future<List<Forecastday>> getForcast(String city,int days) async{

    List<Forecastday> forecast= await api.getForcast(city, days);
    return forecast;
  }

  //SearchRigeon days city weather repo

  Future<List<search_model>> getSearchRigeon(String city)async{

    List<search_model> items=await api.searchRigion(city);
    return items;
  }
}