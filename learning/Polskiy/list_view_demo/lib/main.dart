import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Wetter App',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Wettervorhersage '),
      ),
      body: _buildList(),
    );
  }

  Widget _buildList() {
    return ListView(
      children: [
        _weatherTile('Darmstadt', '25°C', 'Sonnig', Icons.wb_sunny),
        _weatherTile('Paris', '22°C', 'Bewölkt', Icons.cloud),
        _weatherTile('Berlin', '20°C', 'Regen', Icons.water_drop),
        _weatherTile('New York', '28°C', 'Heiter', Icons.wb_sunny),
        _weatherTile('Tokyo', '30°C', 'Wolkig', Icons.cloud),
        _weatherTile('Sydney', '18°C', 'Regen', Icons.water_drop),
        _weatherTile('London', '17°C', 'Teils bewölkt', Icons.wb_sunny),
        _weatherTile('Los Angeles', '32°C', 'Heiter', Icons.wb_sunny),
        _weatherTile('Rio de Janeiro', '26°C', 'Wolkig', Icons.cloud),
        _weatherTile('Cape Town', '23°C', 'Sonnig', Icons.wb_sunny),
      ],
    );
  }


  ListTile _weatherTile(String town, String temperature, String condition, IconData icon) {
    return ListTile(
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            town,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 20,
            ),
          ),
          Text(
            temperature,
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[700],
            ),
          ),
          Text(
            condition,
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[700],
            ),
          ),
        ],
      ),

      leading: Icon(
        icon,
        color: Color.fromARGB(255, 241, 88, 0),
      ),
    );
  }
}