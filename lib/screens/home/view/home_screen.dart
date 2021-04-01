import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:weatherx/models/weather.dart';
import 'package:weatherx/screens/home/cubit/home_cubit.dart';
import 'package:weatherx/utils/size_utils.dart';
import 'package:weatherx/widgets/app_button.dart';
import 'package:weatherx/widgets/weather_background.dart';
import 'package:weatherx/widgets/weather_card.dart';
import 'package:weatherx/widgets/weather_hours_modal.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => HomeCubit()..init(),
        child: Builder(builder: (context) {
          final HomeCubit c = context.watch<HomeCubit>();
          if (c.state.forecast == null) return Container();
          return _WeatherDayView(c.state.forecast.days[c.state.dayIdx]);
        }),
      ),
    );
  }
}

class _WeatherDayView extends StatelessWidget {
  final Weather weather;

  void _handleTapHours(BuildContext context, List<Weather> hours) {
    showWeatherHoursModal(context: context, hoursWeather: hours);
  }

  const _WeatherDayView(this.weather, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final HomeState state = context.read<HomeCubit>().state;
    final List<Weather> hours = state.forecast.findHoursOfDay(weather);

    return WeatherBackground(
      weather,
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            SizedBox(height: 20),
            Text(
              "CHERNIVTSI",
              style: TextStyle(
                fontSize: 18,
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
            Expanded(
              flex: 20,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _SlideButton(SlideDirection.back),
                  SizedBox(width: 5),
                  Expanded(child: WeatherCard(weather)),
                  SizedBox(width: 5),
                  _SlideButton(SlideDirection.next),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Visibility(
                maintainSize: true,
                maintainState: true,
                maintainAnimation: true,
                visible: hours.isNotEmpty,
                child: AppButton(
                  "HOURS",
                  icon: Icons.arrow_drop_up_sharp,
                  onPressed: () => _handleTapHours(context, hours),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _SlideButton extends StatelessWidget {
  final SlideDirection direction;

  const _SlideButton(this.direction, {Key key}) : super(key: key);

  void _handleTap(BuildContext context) {
    context.read<HomeCubit>().slide(direction);
  }

  @override
  Widget build(BuildContext context) {
    final icon = direction == SlideDirection.next
        ? Icons.arrow_forward_ios_outlined
        : Icons.arrow_back_ios_outlined;

    return InkWell(
      onTap: () => _handleTap(context),
      child: Icon(icon, color: Colors.white, size: px(18, context)),
    );
  }
}
