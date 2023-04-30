import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:truth_or_dare_lite/logic/blocs/game_bloc/bloc/game_bloc.dart';
import 'package:truth_or_dare_lite/logic/models/game_mode_model.dart';
import 'package:truth_or_dare_lite/logic/models/player_model.dart';
import 'package:truth_or_dare_lite/screens/components/game_mode_card.dart';
import 'package:truth_or_dare_lite/screens/components/player_badge.dart';
import 'package:truth_or_dare_lite/screens/components/settings_button.dart';
import 'package:truth_or_dare_lite/screens/game_screen.dart';
import 'package:truth_or_dare_lite/utils.dart';

class GameSetupScreen extends StatelessWidget {
  const GameSetupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    void startGame(GameModeModel model) {
      BlocProvider.of<GameBloc>(context)
        ..add(StartGame(model.id))
        ..add(
          EnvokeGameDescision(
            playerModel: BlocProvider.of<GameBloc>(context).state.players.first,
          ),
        );
      platformNavigateTo(
        context: context,
        screen: GameScreen(model),
      );
    }

    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
        actions: const [SettingsButton()],
        title: const Text('Выберите режим игры'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BlocBuilder<GameBloc, GameState>(
                  builder: (context, state) {
                    return Wrap(
                      children: [
                        for (PlayerModel player in state.players)
                          PlayerBadge(
                            player: player,
                            //TODO убрать актив либо здеьс заменить на другой виджет
                            activeId: 0,
                          ),
                      ],
                    );
                  },
                ),
                GridView.count(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  crossAxisCount: 2,
                  mainAxisSpacing: 10,
                  padding:
                      const EdgeInsets.symmetric(vertical: 50, horizontal: 10),
                  children: [
                    GameModeCard(
                      FirstGameModel(),
                      onTap: () {
                        startGame(FirstGameModel());
                      },
                    ),
                    GameModeCard(
                      SecondGameModel(),
                      onTap: () {
                        startGame(SecondGameModel());
                      },
                    ),
                    GameModeCard(
                      ThirdGameModel(),
                      onTap: () {
                        startGame(ThirdGameModel());
                      },
                    ),
                    GameModeCard(
                      FourthGameModel(),
                      onTap: () {
                        startGame(FourthGameModel());
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
