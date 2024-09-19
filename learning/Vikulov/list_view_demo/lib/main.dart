import 'package:flutter/material.dart';
import 'package:weather_icons/weather_icons.dart';

const Color maincolor = Color.fromARGB(255, 212, 99, 0);
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter ListView Beispiel',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Flutter ListView Beispiel'),
          backgroundColor: maincolor,
        ),
        body: _buildList(),
      ),
    );
  }
}

Widget _buildList() {
  return ListView(
    children: [
      _tile('CineArts at the Empire', '85 W Portal Ave', Icons.theaters),
      _tile('The Castro Theater', '429 Castro St', Icons.theaters),
      _tile('Alamo Drafthouse Cinema', '2550 Mission St', Icons.theaters),
      _tile('Roxie Theater', '3117 16th St', Icons.theaters),
      _tile('United Artists Stonestown Twin', '501 Buckingham Way',
          Icons.theaters),
      _tile('AMC Metreon 16', '135 4th St #3000', Icons.theaters),
      const Divider(),
      _tile('K\'s Kitchen', '757 Monterey Blvd', Icons.restaurant),
      _tile('Emmy\'s Restaurant', '1923 Ocean Ave', Icons.restaurant),
      _tile('Chaiya Thai Restaurant', '272 Claremont Blvd', Icons.restaurant),
      _tile('La Ciccia', '291 30th St', Icons.restaurant),
      _tile('Shiraz', 'Kirchstraße 6', Icons.restaurant),
      _tile('Hacienda Mexican Restaurant', 'Rheinstraße 7', Icons.restaurant),
      _tile('Djadoo', 'Rheinstraße 7', Icons.restaurant),
      _tile('Ban Thai', 'Rheinstraße 7', Icons.restaurant),
      _tile('Swaad Indien Restaurant', 'Rheinstraße 7', Icons.restaurant),
      _tile('Jins Haus', 'Rheinstraße 7', Icons.restaurant),
      _tile('Lahore Palace', 'Rheinstraße 7', Icons.restaurant),
      _tile('Khan - Der mongolische Grill', 'Rheinstraße 7', Icons.restaurant),
      _tile('Pizza Mono', 'Rheinstraße 7', Icons.restaurant),
      _tile('Bembelsche', 'Rheinstraße 7', Icons.restaurant),
      const Divider(),
      _tile('klares Wetter', 'eher warm ', WeatherIcons.day_sunny),
      _tile('regnerisches Wetter', 'eher kalt', WeatherIcons.raindrops),
      _tile('stürmisches Wetter', 'unterschiedlich', WeatherIcons.windy),
      _tile('Schnee', 'kalt', WeatherIcons.snowflake_cold),
    ],
  );
}

ListTile _tile(String title, String subtitle, IconData icon) {
  return ListTile(
    title: Text(title,
        style: const TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 20,
        )),
    subtitle: Text(subtitle),
    leading: Icon(
      icon,
      color: maincolor,
    ),
  );
}
