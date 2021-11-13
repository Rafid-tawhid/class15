import 'dart:convert';

import 'package:class15/models/current_weather_response.dart';
import 'package:class15/models/forcast_weather_response.dart';
import 'package:class15/utils/constants.dart';
import 'package:class15/utils/helper_function.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as Http;
import 'package:geolocator/geolocator.dart';

class WeatherProvider extends ChangeNotifier{

  CurrentWeatherResponse currentWeatherResponseModel=CurrentWeatherResponse();
  ForcastWeatherResponse forcastWeatherResponseModel=ForcastWeatherResponse();
  String? city;


  Future<void> getCurrentWeatherData(Position position)async{

    String errMsg='';
    final status=await getTempStatus();
    final unit= status ?'imperial':'metric';
    final urlString='http://api.openweathermap.org/data/2.5/weather?lat=${position.latitude}&lon=${position.longitude}&units=$unit&appid=$weatherApiKey';


    try{
      final response= await Http.get(Uri.parse(urlString));
      final map=json.decode(response.body);
      print("Body :"+response.body);


      if(response.statusCode==200)
        {
          currentWeatherResponseModel=CurrentWeatherResponse.fromJson(map);
          print("Temp :"+currentWeatherResponseModel.main!.temp.toString());
          notifyListeners();

        }
      else
        {
          errMsg=map['message'];
          notifyListeners();
        }

    }
    catch(error)
    {
      throw error;
    }
  }

}