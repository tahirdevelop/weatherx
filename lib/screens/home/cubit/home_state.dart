part of 'home_cubit.dart';

class HomeState {
  final int dayIdx;
  final Forecast forecast;

  const HomeState({
    this.forecast,
    this.dayIdx,
  });

  Weather get day {
    return forecast.days[dayIdx];
  }

  HomeState copyWith({
    int dayIdx,
    Forecast forecast,
  }) {
    return HomeState(
      forecast: forecast ?? this.forecast,
      dayIdx: dayIdx ?? this.dayIdx,
    );
  }
}
