import 'package:flutter/material.dart';
import 'package:tetris_flutter/utils/constants.dart';

class ScoreDisplay extends StatelessWidget {
  final int score;
  final int level;
  final int lines;

  const ScoreDisplay({
    super.key,
    required this.score,
    required this.level,
    required this.lines,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildInfoItem('SCORE', score.toString()),
        const SizedBox(height: 12),
        _buildInfoItem('LEVEL', level.toString()),
        const SizedBox(height: 12),
        _buildInfoItem('LINES', lines.toString()),
      ],
    );
  }

  Widget _buildInfoItem(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            color: Constants.textColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            fontSize: 20,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
