import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _notifictaions = false;

  void _onNotificationsChanged(bool? newValue) {
    if (newValue == null) return;
    setState(() {
      _notifictaions = newValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
      ),
      body: ListView(
        children: [
          Switch(value: _notifictaions, onChanged: _onNotificationsChanged),
          CupertinoSwitch(
              value: _notifictaions, onChanged: _onNotificationsChanged),
          CupertinoCheckbox(
              value: _notifictaions, onChanged: _onNotificationsChanged),
          SwitchListTile(
              value: _notifictaions,
              onChanged: _onNotificationsChanged,
              title: const Text("Enable notification")),
          CheckboxListTile(
            activeColor: Colors.black,
            value: _notifictaions,
            onChanged: _onNotificationsChanged,
            title: const Text("Enable notifications"),
          ),
          ListTile(
            title: const Text("Log out (iOS)"),
            textColor: Colors.red,
            onTap: () => {
              showCupertinoDialog(
                context: context,
                builder: (context) => CupertinoAlertDialog(
                  title: const Text("Are you sure?"),
                  content: const Text("Plx dont go"),
                  actions: [
                    CupertinoDialogAction(
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text("No"),
                    ),
                    CupertinoDialogAction(
                      onPressed: () => Navigator.of(context).pop(),
                      isDestructiveAction: true,
                      child: const Text("Yes"),
                    ),
                  ],
                ),
              ),
            },
          ),
          ListTile(
            title: const Text("Log out (Android)"),
            textColor: Colors.red,
            onTap: () => {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  icon: const FaIcon(FontAwesomeIcons.skull),
                  title: const Text("Are you sure?"),
                  content: const Text("Plx dont go"),
                  actions: [
                    IconButton(
                      onPressed: () => Navigator.of(context).pop(),
                      icon: const FaIcon(
                        FontAwesomeIcons.car,
                      ),
                    ),
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text("Yes"),
                    ),
                  ],
                ),
              ),
            },
          ),
          ListTile(
            onTap: () async {
              final date = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(1980),
                lastDate: DateTime(2030),
              );
              print(date);
              final time = await showTimePicker(
                context: context,
                initialTime: TimeOfDay.now(),
              );
              print(time);
              final booking = await showDateRangePicker(
                context: context,
                firstDate: DateTime(1980),
                lastDate: DateTime(2030),
                builder: (context, child) {
                  return Theme(
                      data: ThemeData(
                          appBarTheme: const AppBarTheme(
                              foregroundColor: Colors.white,
                              backgroundColor: Colors.black)),
                      child: child!);
                },
              );
              print(booking);
            },
            title: const Text("What is your birthday?"),
          ),
          const AboutListTile(),
        ],
      ),
    );
  }
}
