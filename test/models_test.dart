import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tetris_flutter/models/tetromino.dart';
import 'package:tetris_flutter/models/board.dart';
import 'package:tetris_flutter/utils/constants.dart';

void main() {
  group('Tetromino Tests', () {
    test('Tetromino creation should work', () {
      final tetromino = Tetromino.create(TetrominoType.T);
      expect(tetromino.type, TetrominoType.T);
      expect(tetromino.position.row, 0);
      expect(tetromino.position.col, 4);
    });

    test('Tetromino movement should work', () {
      final tetromino = Tetromino.create(TetrominoType.T);
      final moved = tetromino.move(1, 2);
      expect(moved.position.row, 1);
      expect(moved.position.col, 6);
    });

    test('Tetromino rotation should work', () {
      final tetromino = Tetromino.create(TetrominoType.T);
      final rotated = tetromino.rotate();
      expect(rotated.shape, isNot(equals(tetromino.shape)));
    });

    test('All tetromino types should have valid shapes', () {
      for (final type in TetrominoType.values) {
        final tetromino = Tetromino.create(type);
        expect(tetromino.shape, isNotEmpty);
        expect(tetromino.color, isA<Color>());
      }
    });
  });

  group('Board Tests', () {
    test('Board creation should work', () {
      final board = Board(width: Constants.boardWidth, height: Constants.boardHeight);
      expect(board.grid.length, Constants.boardHeight);
      expect(board.grid[0].length, Constants.boardWidth);
    });

    test('Valid position should return true for empty board', () {
      final board = Board(width: Constants.boardWidth, height: Constants.boardHeight);
      final tetromino = Tetromino.create(TetrominoType.T);
      expect(board.isValidPosition(tetromino), isTrue);
    });

    test('Place tetromino should work', () {
      final board = Board(width: Constants.boardWidth, height: Constants.boardHeight);
      final tetromino = Tetromino.create(TetrominoType.T);
      board.placeTetromino(tetromino);
      expect(board.grid[0][4], 'T');
    });

    test('Line full detection should work', () {
      final board = Board(width: 3, height: 3);
      board.grid[2] = ['T', 'T', 'T'];
      expect(board.isLineFull(2), isTrue);
      expect(board.isLineFull(1), isFalse);
    });

    test('Clear line should work', () {
      final board = Board(width: 3, height: 3);
      board.grid[2] = ['T', 'T', 'T'];
      board.clearLine(2);
      expect(board.grid[2], [null, null, null]);
    });

    test('Clear lines should return correct count', () {
      final board = Board(width: 3, height: 3);
      board.grid[2] = ['T', 'T', 'T'];
      board.grid[1] = ['T', 'T', 'T'];
      final cleared = board.clearLines();
      expect(cleared, 2);
    });
  });
}
