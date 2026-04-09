import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tetris_flutter/controllers/game_bloc.dart';
import 'package:tetris_flutter/controllers/game_events.dart';
import 'package:tetris_flutter/views/game_screen.dart';
import 'package:tetris_flutter/utils/constants.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});

  void _showGameOverDialog(BuildContext context, int score) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        backgroundColor: Constants.secondaryColor,
        title: const Text(
          'GAME OVER',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Constants.textColor,
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Score: $score',
              style: const TextStyle(color: Colors.white, fontSize: 20),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              context.read<GameBloc>().add(GameStarted());
            },
            child: const Text(
              'PLAY AGAIN',
              style: TextStyle(color: Constants.textColor, fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constants.primaryColor,
      body: BlocListener<GameBloc, GameState>(
        listener: (context, state) {
          if (state.status == GameStatus.gameOver) {
            _showGameOverDialog(context, state.score);
          }
        },
        child: BlocBuilder<GameBloc, GameState>(
          builder: (context, state) {
            if (state.status == GameStatus.playing || state.status == GameStatus.paused) {
              return const GameScreen();
            }

            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'TETRIS',
                    style: TextStyle(
                      fontSize: 64,
                      fontWeight: FontWeight.bold,
                      color: Constants.textColor,
                      letterSpacing: 8,
                    ),
                  ),
                  const SizedBox(height: 60),
                  ElevatedButton(
                    onPressed: () {
                      context.read<GameBloc>().add(GameStarted());
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 20),
                      backgroundColor: Constants.textColor,
                    ),
                    child: const Text(
                      'START GAME',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
