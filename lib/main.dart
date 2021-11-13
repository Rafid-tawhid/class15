import 'package:class15/pages/weather_home_page.dart';
import 'package:class15/provider/weather_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
void main() {
  runApp(MyApp());
}
class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context)=>WeatherProvider(),
      child: MaterialApp(
          title: 'Flutter Demo',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            fontFamily: 'Merriweather',
            primarySwatch: Colors.blue,
          ),
          home: WeatherHomePage(),
          routes: {
            WeatherHomePage.routeName:(context)=>WeatherHomePage(),
        },

      ),
    );
  }
}


