import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:truth_or_dare_lite/logic/models/player_model.dart';

part 'game_event.dart';
part 'game_state.dart';

class GameBloc extends Bloc<GameEvent, GameState> {
  GameBloc() : super(GameInitial()) {
    on<StartGameSetup>((event, emit) => emit(GameSetup(modeId: event.modeId)));
    on<StartGame>((event, emit) => emit(GameOngoing(modeId: event.modeId)));
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
  }
}
