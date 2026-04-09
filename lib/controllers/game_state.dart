import 'package:equatable/equatable.dart';
import 'package:tetris_flutter/models/tetromino.dart';
import 'package:tetris_flutter/models/board.dart';
import 'package:tetris_flutter/utils/constants.dart';

enum GameStatus { initial, playing, paused, gameOver }

class GameState extends Equatable {
  final Board board;
  final Tetromino? currentTetromino;
  final Tetromino? nextTetromino;
  final int score;
  final int level;
  final int lines;
  final GameStatus status;

  const GameState({
    required this.board,
    this.currentTetromino,
    this.nextTetromino,
    this.score = 0,
    this.level = 1,
    this.lines = 0,
    this.status = GameStatus.initial,
  });

  GameState.initial()
      : board = Board(width: Constants.boardWidth, height: Constants.boardHeight),
        currentTetromino = null,
        nextTetromino = null,
        score = 0,
        level = 1,
        lines = 0,
        status = GameStatus.initial;

  GameState copyWith({
    Board? board,
    Tetromino? currentTetromino,
    Tetromino? nextTetromino,
    int? score,
    int? level,
    int? lines,
    GameStatus? status,
  }) {
    return GameState(
      board: board ?? this.board,
      currentTetromino: currentTetromino ?? this.currentTetromino,
      nextTetromino: nextTetromino ?? this.nextTetromino,
      score: score ?? this.score,
      level: level ?? this.level,
      lines: lines ?? this.lines,
      status: status ?? this.status,
    );
  }

  Duration get dropSpeed {
    final int speedDecrease = (level - 1) * 50;
    final int milliseconds = 800 - speedDecrease;
    return Duration(milliseconds: milliseconds.clamp(100, 800));
  }

  @override
  List<Object?> get props => [board.grid, currentTetromino, nextTetromino, score, level, lines, status];
}
