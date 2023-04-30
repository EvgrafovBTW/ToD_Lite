part of 'game_bloc.dart';

abstract class GameEvent extends Equatable {
  const GameEvent();

  @override
  List<Object> get props => [];
}

//! Эвент редактирования игроков
class AddPlayer extends GameEvent {
  final PlayerModel player;
  const AddPlayer(this.player);
}

class EditPlayer extends GameEvent {
  final PlayerModel player;
  const EditPlayer(this.player);
}

class RemovePlayer extends GameEvent {
  final PlayerModel player;
  const RemovePlayer(this.player);
}

//! Эвенты старта\завершения игры
class StartGame extends GameEvent {
  final int modeId;

  const StartGame(this.modeId);
}

class EndGame extends GameEvent {}

//! Эвенты для игрового цикла
abstract class GameplayEvent extends GameEvent {
  final PlayerModel playerModel;
  const GameplayEvent({required this.playerModel});
}

class EnvokeGameDescision extends GameplayEvent {
  const EnvokeGameDescision({required super.playerModel});
}

class EnvokeGameQuest extends GameplayEvent {
  const EnvokeGameQuest({required super.playerModel});
}

class GameNextTurn extends GameplayEvent {
  const GameNextTurn({required super.playerModel});
}
