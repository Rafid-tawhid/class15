import 'package:class15/utils/helper_function.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {

  static const String routeName='/settings';
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool _isOn=false;


  @override
  void initState() {

    getTempStatus().then((value) {
      setState(() {
        _isOn=value;
      });
      print(value);


    } );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
      ),
      body: ListView(
        children: [
          SwitchListTile(value: _isOn, onChanged:(value) {
            setState(() {
              _isOn=value;
            });
            setTempStatus(value);
          },
            title: const Text("Show Temperacture in Farenhite"),
            subtitle: const Text("Default is Celcious"),
          ),
        ],
      ),
    );
  }
}
