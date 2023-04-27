// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'game_bloc.dart';

class GameState extends Equatable {
  const GameState({this.players = const []});

  final List<PlayerModel> players;

  @override
  List<Object> get props => [players];

  GameState copyWith({
    List<PlayerModel>? players,
  }) {
    return GameState(
      players: players ?? this.players,
    );
  }
}

class GameInitial extends GameState {}

class GameSetup extends GameState {
  final int modeId;
  const GameSetup({
    required this.modeId,
  });
}

class GameOngoing extends GameSetup {
  const GameOngoing({required super.modeId});
}
