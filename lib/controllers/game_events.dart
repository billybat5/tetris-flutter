import 'package:equatable/equatable.dart';

abstract class GameEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GameStarted extends GameEvent {}

class GamePaused extends GameEvent {}

class GameResumed extends GameEvent {}

class GameReset extends GameEvent {}

class TetrominoMoved extends GameEvent {
  final int rowDelta;
  final int colDelta;

  TetrominoMoved({required this.rowDelta, required this.colDelta});

  @override
  List<Object?> get props => [rowDelta, colDelta];
}

class TetrominoRotated extends GameEvent {}

class TetrominoDropped extends GameEvent {}

class TickEvent extends GameEvent {}
