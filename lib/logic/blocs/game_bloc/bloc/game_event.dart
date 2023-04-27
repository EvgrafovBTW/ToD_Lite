part of 'game_bloc.dart';

abstract class GameEvent extends Equatable {
  const GameEvent();

  @override
  List<Object> get props => [];
}

class AddPlayer extends GameEvent {
  final PlayerModel player;
  const AddPlayer(this.player);
}

class RemovePlayer extends GameEvent {
  final PlayerModel player;
  const RemovePlayer(this.player);
}

class StartGameSetup extends GameEvent {
  final int modeId;

  const StartGameSetup(this.modeId);
}

class StartGame extends GameEvent {
  final int modeId;

  const StartGame(this.modeId);
}
