import 'dart:async';
import 'dart:math';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tetris_flutter/controllers/game_events.dart';
import 'package:tetris_flutter/controllers/game_state.dart';
import 'package:tetris_flutter/models/tetromino.dart';
import 'package:tetris_flutter/models/board.dart';
import 'package:tetris_flutter/utils/constants.dart';

class GameBloc extends Bloc<GameEvent, GameState> {
  Timer? _timer;

  GameBloc() : super(const GameState()) {
    on<GameStarted>(_onGameStarted);
    on<GamePaused>(_onGamePaused);
    on<GameResumed>(_onGameResumed);
    on<GameReset>(_onGameReset);
    on<TetrominoMoved>(_onTetrominoMoved);
    on<TetrominoRotated>(_onTetrominoRotated);
    on<TetrominoDropped>(_onTetrominoDropped);
    on<TickEvent>(_onTick);
  }

  final Random _random = Random();

  TetrominoType _getRandomType() {
    return TetrominoType.values[_random.nextInt(TetrominoType.values.length)];
  }

  void _startTimer(Duration duration) {
    _timer?.cancel();
    _timer = Timer.periodic(duration, (_) {
      add(TickEvent());
    });
  }

  void _stopTimer() {
    _timer?.cancel();
    _timer = null;
  }

  void _onGameStarted(GameStarted event, Emitter<GameState> emit) {
    final currentType = _getRandomType();
    final nextType = _getRandomType();
    final newState = state.copyWith(
      currentTetromino: Tetromino.create(currentType),
      nextTetromino: Tetromino.create(nextType),
      status: GameStatus.playing,
    );
    emit(newState);
    _startTimer(newState.dropSpeed);
  }

  void _onGamePaused(GamePaused event, Emitter<GameState> emit) {
    _stopTimer();
    emit(state.copyWith(status: GameStatus.paused));
  }

  void _onGameResumed(GameResumed event, Emitter<GameState> emit) {
    emit(state.copyWith(status: GameStatus.playing));
    _startTimer(state.dropSpeed);
  }

  void _onGameReset(GameReset event, Emitter<GameState> emit) {
    _stopTimer();
    emit(const GameState());
  }

  void _onTetrominoMoved(TetrominoMoved event, Emitter<GameState> emit) {
    if (state.status != GameStatus.playing || state.currentTetromino == null) return;

    final newTetromino = state.currentTetromino!.move(event.rowDelta, event.colDelta);
    if (state.board.isValidPosition(newTetromino)) {
      emit(state.copyWith(currentTetromino: newTetromino));
    }
  }

  void _onTetrominoRotated(TetrominoRotated event, Emitter<GameState> emit) {
    if (state.status != GameStatus.playing || state.currentTetromino == null) return;

    final rotatedTetromino = state.currentTetromino!.rotate();
    
    // Try rotation, then wall kicks if needed
    if (state.board.isValidPosition(rotatedTetromino)) {
      emit(state.copyWith(currentTetromino: rotatedTetromino));
      return;
    }

    // Try wall kicks (move left/right to fit rotation)
    for (final offset in [-1, 1, -2, 2]) {
      final kickedTetromino = rotatedTetromino.move(0, offset);
      if (state.board.isValidPosition(kickedTetromino)) {
        emit(state.copyWith(currentTetromino: kickedTetromino));
        return;
      }
    }
  }

  void _onTetrominoDropped(TetrominoDropped event, Emitter<GameState> emit) {
    if (state.status != GameStatus.playing || state.currentTetromino == null) return;

    Tetromino tetromino = state.currentTetromino!;
    while (true) {
      final next = tetromino.move(1, 0);
      if (!state.board.isValidPosition(next)) break;
      tetromino = next;
    }

    _placeTetrominoAndContinue(emit, tetromino);
  }

  void _onTick(TickEvent event, Emitter<GameState> emit) {
    if (state.status != GameStatus.playing || state.currentTetromino == null) return;

    final newTetromino = state.currentTetromino!.move(1, 0);
    
    if (state.board.isValidPosition(newTetromino)) {
      emit(state.copyWith(currentTetromino: newTetromino));
    } else {
      _placeTetrominoAndContinue(emit, state.currentTetromino!);
    }
  }

  void _placeTetrominoAndContinue(Emitter<GameState> emit, Tetromino current) {
    final board = state.board.copy();
    board.placeTetromino(current);

    // Check for game over
    final nextTetromino = state.nextTetromino!;
    if (board.isGameOver(nextTetromino)) {
      _stopTimer();
      emit(state.copyWith(board: board, status: GameStatus.gameOver, currentTetromino: null));
      return;
    }

    // Clear lines and calculate score
    final linesCleared = board.clearLines();
    final newScore = state.score + _calculateScore(linesCleared, state.level);
    final newLines = state.lines + linesCleared;
    final newLevel = (newLines ~/ Constants.linesPerLevel) + 1;

    final newTetromino = state.nextTetromino!;
    final nextType = _getRandomType();

    final newState = state.copyWith(
      board: board,
      currentTetromino: newTetromino,
      nextTetromino: Tetromino.create(nextType),
      score: newScore,
      lines: newLines,
      level: newLevel,
    );

    emit(newState);
    _startTimer(newState.dropSpeed);
  }

  int _calculateScore(int lines, int level) {
    switch (lines) {
      case 1:
        return Constants.singleLineScore * level;
      case 2:
        return Constants.doubleLineScore * level;
      case 3:
        return Constants.tripleLineScore * level;
      case 4:
        return Constants.tetrisScore * level;
      default:
        return 0;
    }
  }

  @override
  Future<void> close() {
    _stopTimer();
    return super.close();
  }
}
