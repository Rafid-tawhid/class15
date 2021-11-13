import 'package:class15/models/current_weather_response.dart';
import 'package:class15/models/forcast_weather_response.dart';
import 'package:class15/utils/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as Http;

class WeatherProvider extends ChangeNotifier{

  CurrentWeatherResponse currentWeatherResponse=CurrentWeatherResponse();
  ForcastWeatherResponse forcastWeatherResponse=ForcastWeatherResponse();

  Future<void> getCurrentWeatherData(Positioned position)async{
    final urlString='http://api.openweathermap.org/data/2.5/weather?lat=${position.latetude}&lon=${position.lan}=$weatherApiKey';


  }

}