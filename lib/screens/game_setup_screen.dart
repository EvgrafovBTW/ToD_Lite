import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:truth_or_dare_lite/screens/game_screen.dart';
import 'package:truth_or_dare_lite/utils.dart';

class GameSetupScreen extends StatelessWidget {
  const GameSetupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 0),
          //TODO сверстать экран режимов
          child: Column(
            children: [
              Expanded(
                child: Row(
                  children: [
                    BackButton(),
                    Text('Выберите режим игры'),
                  ],
                ),
              ),
              Flexible(
                flex: 3,
                child: GridView.count(
                  crossAxisCount: 2,
                  children: [
                    GameModeCard(
                      'Заполнить профиль',
                      onTap: () {
                        platformNavigateTo(
                          context: context,
                          screen: const GameScreen(),
                        );
                      },
                      icon: const Icon(
                        Icons.person_outline,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class GameModeCard extends StatelessWidget {
  final String label;
  final Widget? icon;
  final VoidCallback onTap;
  const GameModeCard(
    this.label, {
    this.icon,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Expanded(
                child: icon != null
                    ? FittedBox(
                        child: icon!,
                      )
                    : const SizedBox(),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      label,
                      style: TextStyle(
                          fontSize: MediaQuery.of(context).size.height * 0.03),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
