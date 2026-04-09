import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tetris_flutter/controllers/game_bloc.dart';
import 'package:tetris_flutter/controllers/game_events.dart';
import 'package:tetris_flutter/models/board.dart';
import 'package:tetris_flutter/models/tetromino.dart';
import 'package:tetris_flutter/utils/constants.dart';

class GameBoard extends StatelessWidget {
  final Board board;
  final Tetromino? currentTetromino;

  const GameBoard({
    super.key,
    required this.board,
    this.currentTetromino,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragEnd: (details) {
        if (details.primaryVelocity! > 0) {
          context.read<GameBloc>().add(TetrominoMoved(rowDelta: 0, colDelta: 1));
        } else if (details.primaryVelocity! < 0) {
          context.read<GameBloc>().add(TetrominoMoved(rowDelta: 0, colDelta: -1));
        }
      },
      onVerticalDragEnd: (details) {
        if (details.primaryVelocity! > 0) {
          context.read<GameBloc>().add(TetrominoDropped());
        }
      },
      onTap: () {
        context.read<GameBloc>().add(TetrominoRotated());
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Constants.textColor, width: 2),
          color: Constants.secondaryColor,
        ),
        child: CustomPaint(
          size: Size(
            Constants.boardWidth * Constants.cellSize,
            Constants.boardHeight * Constants.cellSize,
          ),
          painter: BoardPainter(
            board: board,
            currentTetromino: currentTetromino,
          ),
        ),
      ),
    );
  }
}

class BoardPainter extends CustomPainter {
  final Board board;
  final Tetromino? currentTetromino;

  BoardPainter({required this.board, this.currentTetromino});

  @override
  void paint(Canvas canvas, Size size) {
    final cellWidth = size.width / Constants.boardWidth;
    final cellHeight = size.height / Constants.boardHeight;

    // Draw grid background
    for (int row = 0; row < Constants.boardHeight; row++) {
      for (int col = 0; col < Constants.boardWidth; col++) {
        final rect = Rect.fromLTWH(
          col * cellWidth,
          row * cellHeight,
          cellWidth,
          cellHeight,
        );

        if (board.grid[row][col] != null) {
          final color = Constants.tetrominoColors[board.grid[row][col]] ?? Colors.grey;
          final paint = Paint()..color = color;
          canvas.drawRect(rect, paint);
          
          // Draw border
          final borderPaint = Paint()
            ..color = Colors.white.withOpacity(0.3)
            ..style = PaintingStyle.stroke
            ..strokeWidth = 1;
          canvas.drawRect(rect, borderPaint);
        } else {
          final paint = Paint()..color = Colors.transparent;
          canvas.drawRect(rect, paint);
          
          // Draw grid lines
          final gridPaint = Paint()
            ..color = Colors.white.withOpacity(0.1)
            ..style = PaintingStyle.stroke
            ..strokeWidth = 0.5;
          canvas.drawRect(rect, gridPaint);
        }
      }
    }

    // Draw current tetromino
    if (currentTetromino != null) {
      for (int row = 0; row < currentTetromino!.shape.length; row++) {
        for (int col = 0; col < currentTetromino!.shape[row].length; col++) {
          if (currentTetromino!.shape[row][col] == 1) {
            final boardRow = currentTetromino!.position.row + row;
            final boardCol = currentTetromino!.position.col + col;
            
            if (boardRow >= 0 && boardRow < Constants.boardHeight &&
                boardCol >= 0 && boardCol < Constants.boardWidth) {
              final rect = Rect.fromLTWH(
                boardCol * cellWidth,
                boardRow * cellHeight,
                cellWidth,
                cellHeight,
              );
              
              final paint = Paint()..color = currentTetromino!.color;
              canvas.drawRect(rect, paint);
              
              final borderPaint = Paint()
                ..color = Colors.white.withOpacity(0.5)
                ..style = PaintingStyle.stroke
                ..strokeWidth = 1;
              canvas.drawRect(rect, borderPaint);
            }
          }
        }
      }
    }
  }

  @override
  bool shouldRepaint(covariant BoardPainter oldDelegate) {
    return oldDelegate.board != board || oldDelegate.currentTetromino != currentTetromino;
  }
}
