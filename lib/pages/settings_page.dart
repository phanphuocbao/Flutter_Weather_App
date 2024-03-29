import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/blocs.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Settings'),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 10.0,
            vertical: 10.0,
          ),
          child: ListTile(
            title: Text('Temperature Unit'),
            subtitle: Text('Celsius/Fahrenheit (Default: Celsius)'),
            trailing: Switch(
              value: context.watch<TempSettingsBloc>().state.tempUnit ==
                  TempUnit.celsius,
              onChanged: (_) {
                context.read<TempSettingsBloc>().add(ToggleTempUnitEvent());
              },
            ),
          ),
        ));
  }
}
