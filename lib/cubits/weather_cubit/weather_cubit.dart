import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/cubits/weather_cubit/weather_states.dart';
import 'package:weather_app/models/weather_model.dart';
import 'package:weather_app/services/weather_service.dart';

class WeatherCubit extends Cubit<WeatherStates> {
  WeatherCubit(this.weatherService) : super(WeatherInitialState());
  WeatherService weatherService;
  WeatherModel? weatherModel;
  void getWeather({required String cityName}) async {
    emit(WeatherLoadingState());
    try {
      weatherModel = await weatherService.getWeather(
        cityName: cityName,
      );
      emit(WeatherSuccessState());
    } on Exception catch (e) {
      emit(WeatherFailureState());
      debugPrint(e.toString());
    }
  }
}
