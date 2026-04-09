import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tetris_flutter/controllers/game_bloc.dart';
import 'package:tetris_flutter/controllers/game_events.dart';
import 'package:tetris_flutter/utils/constants.dart';

class GameControls extends StatelessWidget {
  const GameControls({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildControlButton(
          icon: Icons.arrow_left,
          onPressed: () {
            context.read<GameBloc>().add(TetrominoMoved(rowDelta: 0, colDelta: -1));
          },
        ),
        _buildControlButton(
          icon: Icons.rotate_right,
          onPressed: () {
            context.read<GameBloc>().add(TetrominoRotated());
          },
        ),
        _buildControlButton(
          icon: Icons.arrow_drop_down,
          onPressed: () {
            context.read<GameBloc>().add(TetrominoDropped());
          },
        ),
        _buildControlButton(
          icon: Icons.arrow_right,
          onPressed: () {
            context.read<GameBloc>().add(TetrominoMoved(rowDelta: 0, colDelta: 1));
          },
        ),
      ],
    );
  }

  Widget _buildControlButton({required IconData icon, required VoidCallback onPressed}) {
    return Container(
      width: 70,
      height: 70,
      decoration: BoxDecoration(
        color: Constants.accentColor,
        shape: BoxShape.circle,
        border: Border.all(color: Constants.textColor, width: 2),
      ),
      child: IconButton(
        icon: Icon(icon, size: 36),
        color: Constants.textColor,
        onPressed: onPressed,
      ),
    );
  }
}
