import 'package:equatable/equatable.dart';
import 'package:tetris_flutter/utils/constants.dart';

enum TetrominoType { I, O, T, S, Z, J, L }

class Position extends Equatable {
  final int row;
  final int col;

  const Position({required this.row, required this.col});

  Position copyWith({int? row, int? col}) {
    return Position(row: row ?? this.row, col: col ?? this.col);
  }

  @override
  List<Object?> get props => [row, col];
}

class Tetromino extends Equatable {
  final TetrominoType type;
  final List<List<int>> shape;
  final Position position;

  const Tetromino({
    required this.type,
    required this.shape,
    this.position = const Position(row: 0, col: 0),
  });

  factory Tetromino.create(TetrominoType type) {
    return Tetromino(
      type: type,
      shape: _getShape(type),
      position: const Position(row: 0, col: 4),
    );
  }

  static List<List<int>> _getShape(TetrominoType type) {
    switch (type) {
      case TetrominoType.I:
        return [
          [0, 0, 0, 0],
          [1, 1, 1, 1],
          [0, 0, 0, 0],
          [0, 0, 0, 0],
        ];
      case TetrominoType.O:
        return [
          [1, 1],
          [1, 1],
        ];
      case TetrominoType.T:
        return [
          [0, 1, 0],
          [1, 1, 1],
          [0, 0, 0],
        ];
      case TetrominoType.S:
        return [
          [0, 1, 1],
          [1, 1, 0],
          [0, 0, 0],
        ];
      case TetrominoType.Z:
        return [
          [1, 1, 0],
          [0, 1, 1],
          [0, 0, 0],
        ];
      case TetrominoType.J:
        return [
          [1, 0, 0],
          [1, 1, 1],
          [0, 0, 0],
        ];
      case TetrominoType.L:
        return [
          [0, 0, 1],
          [1, 1, 1],
          [0, 0, 0],
        ];
    }
  }

  Tetromino copyWith({TetrominoType? type, List<List<int>>? shape, Position? position}) {
    return Tetromino(
      type: type ?? this.type,
      shape: shape ?? this.shape,
      position: position ?? this.position,
    );
  }

  Tetromino move(int rowDelta, int colDelta) {
    return copyWith(
      position: position.copyWith(
        row: position.row + rowDelta,
        col: position.col + colDelta,
      ),
    );
  }

  Tetromino rotate() {
    final int n = shape.length;
    final List<List<int>> rotated = List.generate(
      n,
      (i) => List.generate(n, (j) => shape[n - 1 - j][i]),
    );
    return copyWith(shape: rotated);
  }

  String get typeKey => type.name;

  Color get color => Constants.tetrominoColors[typeKey] ?? Colors.white;

  @override
  List<Object?> get props => [type, shape, position];
}
