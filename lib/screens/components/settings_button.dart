import 'package:flutter/material.dart';
import 'package:truth_or_dare_lite/screens/settings_screen.dart';
import 'package:truth_or_dare_lite/utils.dart';

class SettingsButton extends StatelessWidget {
  const SettingsButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () => platformNavigateTo(
        context: context,
        screen: const SettingsScreen(),
      ),
      icon: const Icon(Icons.settings),
    );
  }
}
