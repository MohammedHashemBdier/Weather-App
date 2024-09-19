import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/cubits/weather_cubit/weather_cubit.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({Key? key}) : super(key: key);
  static String? cityName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search a City'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: TextField(
            onChanged: (data) {
              cityName = data;
            },
            onSubmitted: (data) async {
              onSubmitting(data, context);
            },
            decoration: InputDecoration(
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 32, horizontal: 24),
              label: const Text('search'),
              suffixIcon: GestureDetector(
                  onTap: () {
                    if (cityName != null && cityName!.isNotEmpty) {
                      BlocProvider.of<WeatherCubit>(context)
                          .getWeather(cityName: cityName!);
                      BlocProvider.of<WeatherCubit>(context).cityName =
                          cityName;
                      Navigator.pop(context);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text('Please enter a city name')),
                      );
                    }
                  },
                  child: const Icon(Icons.search)),
              border: const OutlineInputBorder(),
              hintText: 'Enter a city',
            ),
          ),
        ),
      ),
    );
  }

  void onSubmitting(String data, BuildContext context) {
    cityName = data;
    BlocProvider.of<WeatherCubit>(context).getWeather(cityName: cityName!);
    BlocProvider.of<WeatherCubit>(context).cityName = cityName;
    Navigator.pop(context);
  }
}
