import 'package:weather_web/data/models/My_Response_Models/condition_model.dart';
import 'package:weather_web/data/models/My_Response_Models/locattion_model.dart';


//Currentweather class use in current weather & location
class CurrentweatherModel {

  CurrentModel current;
  Location_model location;

  CurrentweatherModel(this.current,this.location);

  //factory contructor for this class
  factory CurrentweatherModel.fromJson(json)=>CurrentweatherModel(

      CurrentModel.fromJson(json['current']),
      Location_model.fromJson(json['location']),
  );
}