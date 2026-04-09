import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tetris_flutter/controllers/game_bloc.dart';
import 'package:tetris_flutter/controllers/game_events.dart';
import 'package:tetris_flutter/controllers/game_state.dart';
import 'package:tetris_flutter/widgets/game_board.dart';
import 'package:tetris_flutter/widgets/score_display.dart';
import 'package:tetris_flutter/widgets/next_piece_preview.dart';
import 'package:tetris_flutter/widgets/game_controls.dart';
import 'package:tetris_flutter/utils/constants.dart';

class GameScreen extends StatelessWidget {
  const GameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constants.primaryColor,
      body: BlocBuilder<GameBloc, GameState>(
        builder: (context, state) {
          return SafeArea(
            child: Column(
              children: [
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ScoreDisplay(
                      score: state.score,
                      level: state.level,
                      lines: state.lines,
                    ),
                    NextPiecePreview(tetromino: state.nextTetromino),
                    IconButton(
                      icon: Icon(state.status == GameStatus.paused ? Icons.play_arrow : Icons.pause),
                      color: Constants.textColor,
                      iconSize: 36,
                      onPressed: () {
                        if (state.status == GameStatus.playing) {
                          context.read<GameBloc>().add(GamePaused());
                        } else if (state.status == GameStatus.paused) {
                          context.read<GameBloc>().add(GameResumed());
                        }
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Expanded(
                  child: Center(
                    child: GameBoard(
                      board: state.board,
                      currentTetromino: state.currentTetromino,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                const GameControls(),
                const SizedBox(height: 8),
              ],
            ),
          );
        },
      ),
    );
  }
}
