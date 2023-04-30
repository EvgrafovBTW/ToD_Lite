import 'package:flutter/material.dart';
import 'package:truth_or_dare_lite/logic/models/player_model.dart';

class PlayerBadge extends StatelessWidget {
  const PlayerBadge({
    super.key,
    required this.player,
    required this.activeId,
  });

  final PlayerModel player;
  final int activeId;

  @override
  Widget build(BuildContext context) {
    return Card(
      // padding: const EdgeInsets.all(10),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Wrap(
          children: [
            Icon(
              Icons.person,
              color: player.playerColor,
            ),
            Text(player.name),
            if (activeId == player.id)
              Icon(
                Icons.person,
                color: player.playerColor,
              ),
          ],
        ),
      ),
    );
  }
}
