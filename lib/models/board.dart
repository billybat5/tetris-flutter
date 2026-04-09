import 'package:tetris_flutter/models/tetromino.dart';
import 'package:tetris_flutter/utils/constants.dart';

class Board {
  final List<List<String?>> grid;
  final int width;
  final int height;

  Board({required this.width, required this.height})
      : grid = List.generate(height, (_) => List.filled(width, null));

  Board.fromGrid({required this.grid, required this.width, required this.height});

  bool isValidPosition(Tetromino tetromino) {
    for (int row = 0; row < tetromino.shape.length; row++) {
      for (int col = 0; col < tetromino.shape[row].length; col++) {
        if (tetromino.shape[row][col] == 1) {
          final int boardRow = tetromino.position.row + row;
          final int boardCol = tetromino.position.col + col;

          if (boardRow < 0 || boardRow >= height || boardCol < 0 || boardCol >= width) {
            return false;
          }

          if (grid[boardRow][boardCol] != null) {
            return false;
          }
        }
      }
    }
    return true;
  }

  void placeTetromino(Tetromino tetromino) {
    for (int row = 0; row < tetromino.shape.length; row++) {
      for (int col = 0; col < tetromino.shape[row].length; col++) {
        if (tetromino.shape[row][col] == 1) {
          final int boardRow = tetromino.position.row + row;
          final int boardCol = tetromino.position.col + col;
          if (boardRow >= 0 && boardRow < height && boardCol >= 0 && boardCol < width) {
            grid[boardRow][boardCol] = tetromino.typeKey;
          }
        }
      }
    }
  }

  int clearLines() {
    int linesCleared = 0;
    for (int row = height - 1; row >= 0; row--) {
      if (isLineFull(row)) {
        clearLine(row);
        linesCleared++;
        row++;
      }
    }
    return linesCleared;
  }

  bool isLineFull(int row) {
    return grid[row].every((cell) => cell != null);
  }

  void clearLine(int row) {
    grid.removeAt(row);
    grid.insert(0, List.filled(width, null));
  }

  bool isGameOver(Tetromino tetromino) {
    return !isValidPosition(tetromino.move(0, 0));
  }

  Board copy() {
    return Board.fromGrid(
      grid: grid.map((row) => List<String?>.from(row)).toList(),
      width: width,
      height: height,
    );
  }
}
