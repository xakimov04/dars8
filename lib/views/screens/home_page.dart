import 'package:flutter/material.dart';
import 'package:homework_48/providers/settings_notifier.dart';
import 'package:homework_48/views/widgets/drawer_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

const List<String> dropList = ["uz", "en", "ru"];

class _HomePageState extends State<HomePage> {
  String languageValue = dropList.first;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final settingsNotifier = SettingsNotifier.of(context);
    settingsNotifier.loadSizeText();
  }

  @override
  Widget build(BuildContext context) {
    final settingsNotifier = SettingsNotifier.of(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Home Screen",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.green,
        actions: [
          DropdownButton(
            dropdownColor: Colors.green,
            value: languageValue,
            items: dropList.map<DropdownMenuItem<String>>(
              (value) {
                return DropdownMenuItem(
                    value: value,
                    child: Text(
                      value,
                      style: const TextStyle(color: Colors.white),
                    ));
              },
            ).toList(),
            onChanged: (value) {
              setState(() {
                languageValue = value!;
              });
            },
          ),
        ],
      ),
      drawer: const SpiderDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              height: 200,
              decoration: BoxDecoration(
                image: const DecorationImage(
                  image: AssetImage('assets/images/your_image_name.png'),
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
            const SizedBox(height: 15),
            Text(
              "Amet nostrud ipsum consectetur labore incididunt dolor velit cupidatat in deserunt consequat incididunt culpa magna. Incididunt officia excepteur enim occaecat adipisicing est elit officia. Tempor cillum cupidatat duis in ullamco duis. Cillum irure quis Lorem exercitation nostrud culpa. Non cupidatat fugiat mollit in sit magna sint aute fugiat. Enim ad adipisicing quis laboris et ullamco ut esse ad proident. Labore duis voluptate aute tempor ut ut ipsum.",
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: settingsNotifier.sizeText.size,
                color: settingsNotifier.sizeText.color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
