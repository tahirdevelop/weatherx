import 'package:bloc/bloc.dart';
import 'package:weatherx/core/get_it.dart';
import 'package:weatherx/models/forecast.dart';
import 'package:weatherx/models/weather.dart';
import 'package:weatherx/services/weather_service.dart';

part 'home_state.dart';

enum SlideDirection { next, back }

class HomeCubit extends Cubit<HomeState> {
  final WeatherService weatherService = getIt<WeatherService>();

  HomeCubit() : super(HomeState(dayIdx: 0));

  Future<void> init() async {
    final Forecast forecast = await weatherService.getForecast();
    if (forecast != null) emit(state.copyWith(forecast: forecast));
  }

  void slide(SlideDirection direction) {
    int newIdx =
        direction == SlideDirection.next ? state.dayIdx + 1 : state.dayIdx - 1;

    if (newIdx < 0) newIdx = state.forecast.days.length - 1;
    if (newIdx > state.forecast.days.length - 1) newIdx = 0;

    emit(state.copyWith(dayIdx: newIdx));
  }
}
