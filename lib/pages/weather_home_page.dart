import 'package:class15/pages/settings_page.dart';
import 'package:class15/provider/weather_provider.dart';
import 'package:class15/utils/helper_function.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';

import '../utils/constants.dart';

class WeatherHomePage extends StatefulWidget {

  static const String routeName='/home';



  @override
  _WeatherHomePageState createState() => _WeatherHomePageState();
}

class _WeatherHomePageState extends State<WeatherHomePage> {

  late WeatherProvider _provider;
  bool isInit=true;
  bool _isLoading=true;


  @override
  void didChangeDependencies() {
    if(isInit)
      {
        _provider=Provider.of<WeatherProvider>(context);
       getData();
      }
    isInit=false;

    super.didChangeDependencies();
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Weather App'),
        actions: [
          IconButton(onPressed: (){}, icon: Icon(Icons.add_location)),
          IconButton(onPressed: (){
            showSearch(context: context, delegate: _CitySearchDelegate()).then((city)
            {
              print(city);

              if(city!=null)
                {
                  _provider.city=city;
                  getData();
                }
            });
          }, icon: Icon(Icons.search)),
          IconButton(onPressed: (){
            Navigator.pushNamed(context, SettingsPage.routeName).then((_){
              getData();
            } );
          }, icon: Icon(Icons.settings)),
        ],
      ),
      body: _isLoading ? Center(child: CircularProgressIndicator(),):
      ListView(
        children: [
          Text('${_provider.currentWeatherResponseModel.name}, ${_provider.currentWeatherResponseModel.sys!.country}',style: TextStyle(fontSize: 16),),
          Text('${_provider.currentWeatherResponseModel.main!.temp}\u00B0',style: const TextStyle(fontSize: 80),),
          Text(getFormatedDate(_provider.currentWeatherResponseModel.dt!, 'EEE,MMM dd,yyyy'),style: TextStyle(fontSize: 30),),
          Row(
            children: [


              Image.network('$icon_prefix${_provider.currentWeatherResponseModel.weather![0].icon}${icon_suffix}'),
              Text('Feels Like : +${_provider.currentWeatherResponseModel.weather![0].description}'),
            ],
          )
        ],
      ),
    );
  }
  // Determine the current position of the device.
  ///
  /// When the location services are not enabled or permissions
  /// are denied the `Future` will return an error.
  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition();
  }

  void getData() {
    _determinePosition().then((position){
      _provider.getCurrentWeatherData(position).then((value) {
        setState(() {
          _isLoading=false;
        });
      });

    } );
  }
}

class _CitySearchDelegate extends SearchDelegate{
  @override
  List<Widget>? buildActions(BuildContext context) {
    
    return <Widget>[
      IconButton(onPressed: (){
        query='';
      }, icon: const Icon(Icons.clear))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {

    return IconButton(onPressed: (){
      close(context, query);
    }, icon: const Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {

    return ListTile(
      title: Text(query),
      leading: Icon(Icons.search),
      onTap: (){
        close(context, query);
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {

    final suggestionList=query==null?cities:
        cities.where((city) => city.toLowerCase().startsWith(query.toLowerCase())).toList();
    return  ListView.builder(
      itemCount: suggestionList.length,
      itemBuilder: (context,index)=>ListTile(
        title: Text(suggestionList[index]),
        onTap: (){
          close(context, suggestionList[index]);
        },
      ),

    );
  }
  
}