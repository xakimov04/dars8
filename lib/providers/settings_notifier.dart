import 'package:flutter/material.dart';
import 'package:homework_48/viewmodels/settings_controller.dart';

class SettingsNotifier extends InheritedNotifier<SettingsController> {
  final SettingsController settingsController;

  const SettingsNotifier({
    required this.settingsController,
    required super.child,
    super.key,
  }) : super(notifier: settingsController);

  @override
  bool updateShouldNotify(covariant SettingsNotifier oldWidget) {
    return settingsController != oldWidget.settingsController;
  }

  static SettingsController of(BuildContext context) {
    final data = context.dependOnInheritedWidgetOfExactType<SettingsNotifier>()!;
    return data.settingsController;
  }
}
