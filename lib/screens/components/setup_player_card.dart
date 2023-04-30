import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:truth_or_dare_lite/logic/blocs/game_bloc/bloc/game_bloc.dart';
import 'package:truth_or_dare_lite/logic/models/player_model.dart';
import 'package:truth_or_dare_lite/screens/components/player_add_dialog.dart';

class SetupPlayerCard extends StatelessWidget {
  const SetupPlayerCard(
    this.gameBloc, {
    super.key,
    required this.player,
  });

  final PlayerModel player;
  final GameBloc gameBloc;

  @override
  Widget build(BuildContext context) {
    void addNewPlayer(PlayerModel player) {
      showPlatformDialog(
        context: context,
        builder: (context) => PlayerAddDialog(
          player: player,
        ),
      );
    }

    return GestureDetector(
      onTap: () {
        addNewPlayer(player);
      },
      child: Card(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(
                child: IconButton(
                  onPressed: () {
                    addNewPlayer(player);
                  },
                  icon: Icon(
                    Icons.person,
                    color: player.playerColor,
                  ),
                ),
              ),
              Expanded(
                flex: 6,
                child: Text(player.name),
              ),
              Flexible(
                child: IconButton(
                  icon: const Icon(Icons.cancel),
                  onPressed: () => gameBloc.add(
                    RemovePlayer(player),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
