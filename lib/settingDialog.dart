import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsDialog extends StatefulWidget {
  const SettingsDialog({super.key});

  @override
  _SettingsDialogState createState() => _SettingsDialogState();
}

class _SettingsDialogState extends State<SettingsDialog> {
  bool isDarkMode = false;
  double fontSize = 16.0;
  String selectedLanguage = 'English';

  @override
  void initState() {
    super.initState();
    _loadSettings(); // Load saved settings
  }

  // Load saved preferences
  _loadSettings() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      isDarkMode = prefs.getBool('isDarkMode') ?? false;
      fontSize = prefs.getDouble('fontSize') ?? 16.0;
      selectedLanguage = prefs.getString('language') ?? 'English';
    });
  }

  // Save preferences
  _saveSettings() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isDarkMode', isDarkMode);
    prefs.setDouble('fontSize', fontSize);
    prefs.setString('language', selectedLanguage);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Settings'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Dark mode toggle
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Dark Mode'),
                Switch(
                  activeColor: Colors.teal[300],
                  inactiveThumbColor: Colors.teal[300],
                  inactiveTrackColor: Colors.orange[300],
                  value: isDarkMode,
                  onChanged: (value) {
                    setState(() {
                      isDarkMode = value;
                    });
                    _saveSettings();
                  },
                ),
              ],
            ),

            // Font size slider
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Font Size'),
                Slider(
                  activeColor: Colors.teal[300],
                  inactiveColor: Colors.orange,
                  value: fontSize,
                  min: 12.0,
                  max: 24.0,
                  onChanged: (value) {
                    setState(() {
                      fontSize = value;
                    });
                    _saveSettings();
                  },
                ),
              ],
            ),

            // Language selection
            Text('Language'),
            RadioListTile<String>(
              activeColor: Colors.teal[300],
              title: Text('English'),
              value: 'English',
              groupValue: selectedLanguage,
              onChanged: (value) {
                setState(() {
                  selectedLanguage = value!;
                });
                _saveSettings();
              },
            ),
            RadioListTile<String>(
              activeColor: Colors.teal[300],
              title: Text('فارسی'),
              value: 'Persian',
              groupValue: selectedLanguage,
              onChanged: (value) {
                setState(() {
                  selectedLanguage = value!;
                });
                _saveSettings();
              },
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('Close', style: TextStyle(color: Colors.orange),),
        ),
      ],
    );
  }
}
