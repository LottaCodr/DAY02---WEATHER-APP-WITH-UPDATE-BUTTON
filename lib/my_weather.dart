import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MyWeather extends StatefulWidget {
  const MyWeather({Key? key}) : super(key: key);

  @override
  State<MyWeather> createState() => _MyWeatherState();
}

class _MyWeatherState extends State<MyWeather> {
  String city = 'Abuja';
  String temp = '';

  Future<void> _fetchWeather() async {
    http.Response response = await http.get(Uri.parse('https://api.tomorrow.io/v4/weather/forecast?location=lagos&apikey=B2k7j9mW3K3uSDyMoJQ0Bw1aXP8CIyWE'));
    Map data = jsonDecode(response.body);
    //print(data['temperature']);

    setState(() {
      temp = data['timelines']['minutely'][0]['values']['temperature'].toString();
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
        centerTitle: true,
        elevation: 0,
      ),


      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children:  <Widget>[

            Text('Your current city is $city',
              style: const TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.w600
            ),),

            const SizedBox (height: 10.0,),

            Text("The weather in $city is $temp (°F)",
            style: const TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.w600
            ),),

            const SizedBox(height: 20.0,),

            ElevatedButton.icon(
                onPressed: (){
                  _fetchWeather();
                }, icon: const Icon(Icons.thermostat),
                    label: Text('Update Temperature'))



          ],
        ),
      ),
    );
  }
}
