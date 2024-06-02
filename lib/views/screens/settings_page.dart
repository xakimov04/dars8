import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:homework_48/providers/settings_notifier.dart';
import 'package:homework_48/views/widgets/drawer_widget.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  Color pickerColor = Colors.white;
  Color currentColor = Colors.white;

  void changeColor(Color color) {
    setState(() => pickerColor = color);
  }

  @override
  Widget build(BuildContext context) {
    final settingsNotifier = SettingsNotifier.of(context);
    return Scaffold(
      drawer: const DrawerWidget(),
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Settings",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            ListenableBuilder(
              listenable: settingsNotifier,
              builder: (context, child) {
                return SwitchListTile(
                  title: Text(
                    "Dark mode",
                    style: TextStyle(
                      fontSize: settingsNotifier.sizeText.size,
                      color: settingsNotifier.sizeText.color,
                    ),
                  ),
                  value: settingsNotifier.appTheme.themeMode == ThemeMode.dark,
                  onChanged: (value) {
                    settingsNotifier.toggleTheme(value);
                  },
                );
              },
            ),
            Text(
              "Text Size:",
              style: TextStyle(
                fontSize: settingsNotifier.sizeText.size,
                color: settingsNotifier.sizeText.color,
              ),
            ),
            ListenableBuilder(
              listenable: settingsNotifier,
              builder: (context, child) {
                return Slider(
                  value: settingsNotifier.sizeText.size,
                  min: 12,
                  max: 30,
                  divisions: 18,
                  label: settingsNotifier.sizeText.size.toString(),
                  onChanged: (value) async {
                    settingsNotifier.setSizeText(value);
                    await settingsNotifier.loadSizeText();
                  },
                );
              },
            ),
            ElevatedButton(
              onPressed: () async {
                Color? selectedColor = await showDialog<Color>(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      actions: [
                        FilledButton(
                          onPressed: () {
                            Navigator.pop(context, pickerColor);
                          },
                          child: const Text("Save"),
                        ),
                      ],
                      title: const Text(
                        'Pick a color!',
                      ),
                      content: SingleChildScrollView(
                        child: BlockPicker(
                          pickerColor: pickerColor,
                          onColorChanged: changeColor,
                        ),
                      ),
                    );
                  },
                );
                if (selectedColor != null) {
                  settingsNotifier.setColor(selectedColor);
                }
              },
              child: Text(
                "Select color",
                style: TextStyle(
                  fontSize: settingsNotifier.sizeText.size,
                  color: settingsNotifier.sizeText.color,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
