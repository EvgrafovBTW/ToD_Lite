import 'package:flutter/material.dart';
import 'package:truth_or_dare_lite/logic/models/game_mode_model.dart';

class GameModeCard extends StatelessWidget {
  final GameModeModel model;
  final VoidCallback onTap;
  const GameModeCard(
    this.model, {
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
          padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
          child: Column(
            children: [
              Expanded(
                  child: FittedBox(
                child: model.icon,
              )),
              Expanded(
                flex: 2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      model.title,
                      style: TextStyle(
                          fontSize: MediaQuery.of(context).size.height * 0.025),
                      textAlign: TextAlign.center,
                    ),
                    if (model.description != null)
                      Text(
                        model.description!,
                        style: TextStyle(
                            fontSize:
                                MediaQuery.of(context).size.height * 0.015,
                            color: Theme.of(context).hintColor),
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
