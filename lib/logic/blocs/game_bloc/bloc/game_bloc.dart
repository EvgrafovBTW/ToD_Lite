import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:truth_or_dare_lite/logic/models/player_model.dart';

part 'game_event.dart';
part 'game_state.dart';

class GameBloc extends Bloc<GameEvent, GameState> {
  GameBloc() : super(const GameState()) {
    on<StartGame>(
      (event, emit) => emit(
        GameOngoing(
          modeId: event.modeId,
          players: state.players,
          activePlayerId: 0,
        ),
      ),
    );
    on<EndGame>((event, emit) => emit(GameState(players: state.players)));

    on<AddPlayer>((event, emit) {
      List<PlayerModel> newPlayerList = List.from(state.players);
      newPlayerList.add(event.player);
      emit(
        state.copyWith(
          players: newPlayerList,
        ),
      );
    });
    on<RemovePlayer>((event, emit) {
      List<PlayerModel> newPlayerList = List.from(state.players);
      newPlayerList.removeWhere((p) => p.id == event.player.id);
      emit(
        state.copyWith(
          players: newPlayerList,
        ),
      );
    });
    on<EditPlayer>((event, emit) {
      List<PlayerModel> newPlayerList = List.from(state.players);
      int index = newPlayerList
          .indexOf(newPlayerList.firstWhere((p) => p.id == event.player.id));
      newPlayerList.removeAt(index);
      newPlayerList.insert(index, event.player);
      emit(
        state.copyWith(
          players: newPlayerList,
        ),
      );
    });

    on<EnvokeGameDescision>(
      (event, emit) {
        PlayerModel player = event.playerModel;
        if (state is GameOngoingPlayerDeicide ||
            state is GameOngoingPlayerQuest) {
          if (player.id != state.players.last.id) {
            player = state.players.elementAt(state.players.indexOf(player) + 1);
          } else {
            player = state.players.first;
          }
        }
        emit(
          GameOngoingPlayerDeicide(
            modeId: state.modeId,
            players: state.players,
            activePlayerId: player.id,
          ),
        );
      },
    );
    on<EnvokeGameQuest>(
      (event, emit) => emit(
        GameOngoingPlayerQuest(
          modeId: state.modeId,
          players: state.players,
          activePlayerId: event.playerModel.id,
        ),
      ),
    );
  }
}
