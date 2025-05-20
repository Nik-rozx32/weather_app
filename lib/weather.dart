import 'package:flutter/material.dart';
import 'package:weather_app/weather_service.dart';
import 'models/weather_model.dart';
import 'models/weather_request_model.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({Key? key}) : super(key: key);

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  final _controller = TextEditingController();
  final WeatherService _weatherService = WeatherService();
  Weather? _weather;
  String? _err;
  bool _isLoading = false;

  void _search() async {
    setState(() {
      _isLoading = true;
      _err = null;
    });

    try {
      final weather = await _weatherService
          .fetchWeather(WeatherRequest(city: _controller.text.trim()));
      setState(() {
        _weather = weather;
      });
    } catch (e) {
      print('❌ Error fetching weather: $e'); // ✅ This will show the real error
      setState(() {
        _err = 'Could not fetch weather.';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather App'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: const InputDecoration(
                labelText: 'Enter City Name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _search,
              child: Text('Get Weather'),
            ),
            const SizedBox(height: 20),
            if (_err != null)
              Text(
                _err!,
                style: const TextStyle(color: Colors.red),
              ),
            if (_weather != null) ...[
              Text(
                _weather!.cityName,
                style:
                    const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              Text('${_weather!.temperature}°C',
                  style: const TextStyle(fontSize: 20)),
              const SizedBox(height: 20),
              Text(_weather!.description),
              const SizedBox(height: 20),
              Image.network(
                'https://openweathermap.org/img/wn/${_weather!.icon}@2x.png',
              ),
            ],
          ],
        ),
      ),
    );
  }
}
