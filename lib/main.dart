import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'blocs/blocs.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_weather_app/pages/home_page.dart';
import 'package:flutter_weather_app/repositories/weather_repositoriy.dart';
import 'package:flutter_weather_app/services/weather_api_services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => WeatherRepository(
        weatherApiServices: WeatherApiServices(
          httpClient: http.Client(),
        ),
      ),
      child: MultiBlocProvider(
          providers: [
            BlocProvider<WeatherBloc>(
              create: (context) => WeatherBloc(
                weatherRepository: context.read<WeatherRepository>(),
              ),
            ),
            BlocProvider<TempSettingsBloc>(
              create: (context) => TempSettingsBloc(),
            ),
            BlocProvider<ThemeBloc>(
              create: (context) => ThemeBloc(),
            ),
          ],
          child: BlocListener<WeatherBloc, WeatherState>(
            listener: (context, state) {
              context.read<ThemeBloc>().setTheme(state.weather.theTemp);
            },
            child: BlocListener<WeatherBloc, WeatherState>(
              listener: (context, state) {
                context.read<ThemeBloc>().setTheme(state.weather.theTemp);
              },
              child: BlocBuilder<ThemeBloc, ThemeState>(
                builder: (context, state) {
                  return MaterialApp(
                    title: 'Weather App',
                    debugShowCheckedModeBanner: false,
                    theme: state.appTheme == AppTheme.light
                        ? ThemeData.light()
                        : ThemeData.dark(),
                    home: HomePage(),
                  );
                },
              ),
            ),
          )),
    );
  }
}
