import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class Weather {
  final String day;
  final String temperature;

  Weather(this.day, this.temperature);
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather App',
      home: WeatherScreen(),
    );
  }
}

class WeatherScreen extends StatelessWidget {
  final List<Weather> weatherData = [
    Weather('Monday', '25°C'),
    Weather('Tuesday', '24°C'),
    Weather('Wednesday', '26°C'),
    Weather('Thursday', '23°C'),
    Weather('Friday', '28°C'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Weather Forecast'),
      ),
      body: ListView.builder(
        itemCount: weatherData.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(weatherData[index].day),
            subtitle: Text('Temperature: ${weatherData[index].temperature}'),
            leading: Icon(Icons.wb_sunny),
          );
        },
      ),
    );
  }
}
