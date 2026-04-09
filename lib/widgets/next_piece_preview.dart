import 'package:flutter/material.dart';
import 'package:tetris_flutter/models/tetromino.dart';
import 'package:tetris_flutter/utils/constants.dart';

class NextPiecePreview extends StatelessWidget {
  final Tetromino? tetromino;

  const NextPiecePreview({super.key, this.tetromino});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'NEXT',
          style: TextStyle(
            fontSize: 12,
            color: Constants.textColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            color: Constants.secondaryColor,
            border: Border.all(color: Constants.textColor),
          ),
          child: Center(
            child: tetromino != null ? _buildPiecePreview() : const SizedBox(),
          ),
        ),
      ],
    );
  }

  Widget _buildPiecePreview() {
    return CustomPaint(
      size: const Size(60, 60),
      painter: PiecePreviewPainter(tetromino: tetromino!),
    );
  }
}

class PiecePreviewPainter extends CustomPainter {
  final Tetromino tetromino;

  PiecePreviewPainter({required this.tetromino});

  @override
  void paint(Canvas canvas, Size size) {
    final cellSize = 15.0;
    final offsetX = (size.width - tetromino.shape[0].length * cellSize) / 2;
    final offsetY = (size.height - tetromino.shape.length * cellSize) / 2;

    for (int row = 0; row < tetromino.shape.length; row++) {
      for (int col = 0; col < tetromino.shape[row].length; col++) {
        if (tetromino.shape[row][col] == 1) {
          final rect = Rect.fromLTWH(
            offsetX + col * cellSize,
            offsetY + row * cellSize,
            cellSize,
            cellSize,
          );
          
          final paint = Paint()..color = tetromino.color;
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

  @override
  bool shouldRepaint(covariant PiecePreviewPainter oldDelegate) {
    return oldDelegate.tetromino != tetromino;
  }
}
