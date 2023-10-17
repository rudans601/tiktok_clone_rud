import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tiktok_clone/constants/breakpoints.dart';
import 'package:tiktok_clone/features/videos/view_models/playback_config_vm.dart';

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
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: Breakpoints.md),
          child: ListView(
            children: [
              SwitchListTile.adaptive(
                value: context.watch<PlaybackConfigViewModel>().muted,
                onChanged: (value) =>
                    context.read<PlaybackConfigViewModel>().setMuted(value),
                title: const Text("Mute video"),
                subtitle: const Text("Video will be muted by default."),
              ),
              SwitchListTile.adaptive(
                value: context.watch<PlaybackConfigViewModel>().autoplay,
                onChanged: (value) =>
                    context.read<PlaybackConfigViewModel>().setAutoplay(value),
                title: const Text("Autoplay"),
                subtitle: const Text("Video will start playing automatically"),
              ),
              SwitchListTile.adaptive(
                value: _notifictaions,
                onChanged: _onNotificationsChanged,
                title: const Text("Enable notifications"),
                subtitle: const Text("They will be cute."),
              ),
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
                title: const Text("Log out (iOS / Bottom)"),
                textColor: Colors.red,
                onTap: () => {
                  showCupertinoModalPopup(
                    context: context,
                    builder: (context) => CupertinoActionSheet(
                      title: const Text("Are you sure?"),
                      message: const Text("Please dooooont goooooo"),
                      actions: [
                        CupertinoActionSheetAction(
                          isDefaultAction: true,
                          onPressed: () => Navigator.of(context).pop(),
                          child: const Text("Not log out"),
                        ),
                        CupertinoActionSheetAction(
                          isDestructiveAction: true,
                          onPressed: () => Navigator.of(context).pop(),
                          child: const Text("Yes plz"),
                        ),
                      ],
                    ),
                  ),
                },
              ),
              const ListTile(),
              const AboutListTile(),
            ],
          ),
        ),
      ),
    );
  }
}
