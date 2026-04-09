import 'package:flutter/material.dart';

class Constants {
  Constants._();

  // Game constants
  static const int boardWidth = 10;
  static const int boardHeight = 20;
  static const double cellSize = 30.0;
  
  // Timing constants
  static const Duration initialDropSpeed = Duration(milliseconds: 800);
  static const Duration fastDropSpeed = Duration(milliseconds: 50);
  
  // Scoring constants
  static const int singleLineScore = 100;
  static const int doubleLineScore = 300;
  static const int tripleLineScore = 500;
  static const int tetrisScore = 800;
  static const int linesPerLevel = 10;
  
  // Colors for tetrominoes
  static const Map<String, Color> tetrominoColors = {
    'I': Color(0xFF00FFFF),
    'O': Color(0xFFFFFF00),
    'T': Color(0xFF800080),
    'S': Color(0xFF00FF00),
    'Z': Color(0xFFFF0000),
    'J': Color(0xFF0000FF),
    'L': Color(0xFFFFA500),
  };

  // UI Colors
  static const Color primaryColor = Color(0xFF1A1A2E);
  static const Color secondaryColor = Color(0xFF16213E);
  static const Color accentColor = Color(0xFF0F3460);
  static const Color textColor = Color(0xFFE94560);
}
