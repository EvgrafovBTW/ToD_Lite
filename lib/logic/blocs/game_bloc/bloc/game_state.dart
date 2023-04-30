// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'game_bloc.dart';

class GameState extends Equatable {
  const GameState(
      {this.players = const [], this.modeId = 0, this.activePlayerId = 0});

  final List<PlayerModel> players;
  final int modeId;
  final int activePlayerId;

  @override
  List<Object> get props => [players, modeId, activePlayerId];

  GameState copyWith({
    List<PlayerModel>? players,
  }) {
    return GameState(
      players: players ?? this.players,
    );
  }
}

class GameOngoing extends GameState {
  const GameOngoing({
    required super.players,
    required super.modeId,
    required super.activePlayerId,
  });
}

class GameOngoingPlayerDeicide extends GameOngoing {
  const GameOngoingPlayerDeicide({
    required super.modeId,
    required super.players,
    required super.activePlayerId,
  });
}

class GameOngoingPlayerQuest extends GameOngoing {
  const GameOngoingPlayerQuest({
    required super.modeId,
    required super.players,
    required super.activePlayerId,
  });
}
