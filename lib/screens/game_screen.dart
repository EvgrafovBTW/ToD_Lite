import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:truth_or_dare_lite/logic/blocs/game_bloc/bloc/game_bloc.dart';
import 'package:truth_or_dare_lite/logic/models/game_mode_model.dart';
import 'package:truth_or_dare_lite/logic/models/player_model.dart';
import 'package:truth_or_dare_lite/screens/components/player_badge.dart';
import 'package:truth_or_dare_lite/screens/components/settings_button.dart';

class GameScreen extends StatelessWidget {
  final GameModeModel gameModeModel;
  const GameScreen(this.gameModeModel, {super.key});

  @override
  Widget build(BuildContext context) {
    GameBloc gameBloc = BlocProvider.of<GameBloc>(context);
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          onPressed: () {
            gameBloc.add(EndGame());
            Navigator.pop(context);
          },
        ),
        actions: const [SettingsButton()],
        title: Text(gameModeModel.title),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: BlocBuilder<GameBloc, GameState>(
            builder: (context, state) {
              // int playerIndex = state.players.indexOf(state.)
              PlayerModel currentPlayer =
                  state.players.elementAt(state.activePlayerId);
              return Column(
                children: [
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 20,
                        horizontal: 40,
                      ),
                      child: Row(
                        children: [
                          Text(gameModeModel.title + state.modeId.toString()),
                        ],
                      ),
                    ),
                  ),
                  for (PlayerModel player in state.players)
                    PlayerBadge(
                      player: player,
                      activeId: state.activePlayerId,
                    ),
                  ElevatedButton(
                    onPressed: () {
                      gameBloc.add(
                        EnvokeGameDescision(playerModel: currentPlayer),
                      );
                    },
                    child: Text('sasdasdasd'),
                  )
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
