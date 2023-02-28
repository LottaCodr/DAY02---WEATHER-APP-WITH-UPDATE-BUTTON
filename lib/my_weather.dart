import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MyWeather extends StatefulWidget {
  const MyWeather({Key? key}) : super(key: key);

  @override
  State<MyWeather> createState() => _MyWeatherState();
}

class _MyWeatherState extends State<MyWeather> {
  var city = 'Abuja';
  var temp = '';
  var humidity = '';
  var windspeed = '';
  var rain = '';


  Future<void> _fetchWeather() async {
    http.Response response = await http.get(Uri.parse('https://api.tomorrow.io/v4/weather/forecast?location=lagos&apikey=B2k7j9mW3K3uSDyMoJQ0Bw1aXP8CIyWE'));
    Map data = jsonDecode(response.body);
    //print(data['temperature']);

    setState(() {
      temp = data['timelines']['minutely'][0]['values']['temperature'].toString();
      rain = data['timelines']['minutely'][0]['values']['rainIntensity'].toString();
      windspeed = data['timelines']['minutely'][0]['values']['windSpeed'].toString();
      humidity = data['timelines']['minutely'][0]['values']['humidity'].toString();
    });

  }


  @override
  void initState() {
    super.initState();
    _fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: const Text('WEATHER FORECAST'),
        titleTextStyle: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 22.0,
          letterSpacing: 2.0,
        ),
        backgroundColor: Colors.red,
        centerTitle: true,
        elevation: 0,
      ),


      body: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height /1.5,
            width:  MediaQuery.of(context).size.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 10.0),
                child: Text('Currently in $city',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16.0,

                ),),),

                Text(temp != null? temp + "°F": 'loading',
                style: TextStyle(
                  fontSize: 40.0,
                  fontWeight: FontWeight.w600,

                ),),

                Padding(padding: EdgeInsets.only(bottom: 10.0),
                child: Text('..And it is raining here',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16.0,
                ),),),

                SizedBox(height: 30,),

                Expanded(
                  child:Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: ListView(
                        children:  [
                          //For the temperature
                          ListTile(
                            leading: FaIcon(FontAwesomeIcons.temperatureHalf),
                            title: Text('Temperature is:'),
                            trailing: Text(temp != null? temp + "°F": "loading"),

                          ),

                          //For the Weather Description
                          ListTile(
                            leading: FaIcon(FontAwesomeIcons.cloudBolt),
                            title: Text('Weather'),
                            trailing: Text(rain != null? rain: 'loading'),
                          ),

                          //For the humidity
                          ListTile(
                            leading: FaIcon(FontAwesomeIcons.cloudSun),
                            title: Text('Humidity'),
                            trailing: Text(humidity!= null? humidity: "loading" + "°F"),
                          ),

                          //For the windspeed
                          ListTile(
                            leading: FaIcon(FontAwesomeIcons.wind),
                            title: Text('Wind Speed'),
                            trailing: Text(windspeed != null? windspeed: "loading"),
                          ),

                          SizedBox(height: 30.0,),

                          ElevatedButton.icon(
                              onPressed: _fetchWeather,
                              icon: FaIcon(FontAwesomeIcons.sun),
                              label: Text('Update Weather'),
                              style: ButtonStyle(
                                backgroundColor: MaterialStatePropertyAll(Colors.red)
                              ),)
                        ],
                      ),
                    ))
              ],
            ),
          )
        ],
      )
    );
  }
}
