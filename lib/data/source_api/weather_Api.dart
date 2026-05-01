import 'dart:convert';
import 'package:http/http.dart 'as http;
import 'package:weather_web/data/models/My_Response_Models/Search_model.dart';
import 'package:weather_web/data/models/My_Response_Models/forcastDay_model.dart';
import 'package:weather_web/data/models/currentWeather_model/currentWeather_model.dart';
import 'package:weather_web/utils/showFailureMsg.dart';

class WeatherApi {

  String baseUrl='http://api.weatherapi.com/v1';

  Future<CurrentweatherModel?> getCurrentWeather(String city)async{

    try{
      final res=await http.get(Uri.parse('$baseUrl//forecast.json?key=aa8a914da1a7474aae8154104262804&q=$city&days=1&aqi=no&alerts=no'));
      final data=await jsonDecode(res.body);
      CurrentweatherModel response=CurrentweatherModel.fromJson(data);
      return response;
    }catch(e){
      print(e);
    }
    return null;
  }

  Future<List<Forecastday>> getForcast(String city,int days)async{
    
    try{
    final res=  await http.get(Uri.parse('$baseUrl/forecast.json?key=aa8a914da1a7474aae8154104262804&q=$days&$days=1&aqi=no&alerts=no'));
    final data=jsonDecode(res.body);
    List dataList=data['forecast']['forecastday'];
    List<Forecastday> forecastdays=dataList.map((e)=>Forecastday.fromJson(e)).toList();
    return forecastdays;
    }catch(e){
      showMsg(e.toString());
    }
    return [];
  }
  
  Future<List<search_model>> searchRigion(String city)async{
    
    try{
      final res=await http.get(Uri.parse('$baseUrl/search.json?key=aa8a914da1a7474aae8154104262804&q=$city'));
      List data =jsonDecode(res.body);
      List<search_model> items=data.map((e)=>search_model.fromJson(e)).toList();
      return items;
    }catch(e){
      showMsg(e.toString());
    }
    return [];
  }
}