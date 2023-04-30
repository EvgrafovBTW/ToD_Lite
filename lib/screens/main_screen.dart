import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:truth_or_dare_lite/logic/blocs/game_bloc/bloc/game_bloc.dart';
import 'package:truth_or_dare_lite/logic/models/player_model.dart';
import 'package:truth_or_dare_lite/screens/components/player_add_dialog.dart';
import 'package:truth_or_dare_lite/screens/components/settings_button.dart';
import 'package:truth_or_dare_lite/screens/components/setup_player_card.dart';
import 'package:truth_or_dare_lite/screens/game_setup_screen.dart';
import 'package:truth_or_dare_lite/utils.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    GameBloc gameBloc = BlocProvider.of<GameBloc>(context);
    void addNewPlayer() {
      showPlatformDialog(
        context: context,
        builder: (context) => const PlayerAddDialog(),
      );
    }

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: addNewPlayer,
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        actions: const [SettingsButton()],
      ),
      body: SafeArea(
        child: SizedBox.expand(
          child: BlocBuilder<GameBloc, GameState>(
            builder: (context, state) {
              return Column(
                children: [
                  Expanded(
                    flex: 10,
                    child: state.players.isEmpty
                        ? Column(
                            children: [
                              TextButton(
                                onPressed: addNewPlayer,
                                child:
                                    const Text('Для начала добавьте игроков'),
                              ),
                            ],
                          )
                        : SingleChildScrollView(
                            child: Column(
                              children: [
                                for (PlayerModel player in state.players)
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 15),
                                    child: SetupPlayerCard(
                                      gameBloc,
                                      player: player,
                                    ),
                                  ),
                              ],
                            ),
                          ),
                  ),
                  Flexible(
                    flex: 2,
                    child: ElevatedButton(
                      onPressed: () {
                        if (gameBloc.state.players.length < 2) {
                          showSimpleNotification(
                            const Text(
                              'Для начала игры необходимо как минимум 2 игрока!',
                              textAlign: TextAlign.center,
                            ),
                          );
                        } else {
                          platformNavigateTo(
                            context: context,
                            screen: const GameSetupScreen(),
                          );
                        }
                      },
                      child: const Text(
                        'Продолжить',
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
