import 'package:flutter/material.dart';
import 'package:homework_48/data/local_data.dart';
import 'package:homework_48/providers/settings_notifier.dart';
import 'package:homework_48/viewmodels/settings_controller.dart';
import 'package:homework_48/views/screens/home_page.dart';

void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  final settingsController = SettingsController(
    themeModeData: LocalData(),
    sizeTextData: LocalData(),
  );
  await settingsController.loadTheme();
  await settingsController.loadSizeText();
  await settingsController.loadColorText();

  runApp(MainRunner(settingsController: settingsController));
}

class MainRunner extends StatelessWidget {
  final SettingsController settingsController;

  const MainRunner({super.key, required this.settingsController});

  @override
  Widget build(BuildContext context) {
    return SettingsNotifier(
      settingsController: settingsController,
      child: Builder(
        builder: (context) {
          final settingsNotifier = SettingsNotifier.of(context);
          return AnimatedBuilder(
            animation: settingsNotifier,
            builder: (context, child) {
              return MaterialApp(
                debugShowCheckedModeBanner: false,
                darkTheme: ThemeData.dark(useMaterial3: true),
                themeMode: settingsNotifier.appTheme.themeMode,
                home: const HomePage(),
              );
            },
          );
        },
      ),
    );
  }
}
