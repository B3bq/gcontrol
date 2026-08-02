import 'dart:math' as math;

import 'package:flutter/material.dart';

@immutable
class FieldHeatmapPoint {
  const FieldHeatmapPoint({
    required this.x,
    required this.y,
    this.intensity = 1.0,
  });

  final double x;
  final double y;
  final double intensity;
}

class FieldHeatmap extends StatelessWidget {
  const FieldHeatmap({
    super.key,
    this.points,
    this.padding = const EdgeInsets.all(8),
    this.columns = 10,
    this.rows = 14,
  });

  final List<FieldHeatmapPoint>? points;
  final EdgeInsets padding;
  final int columns;
  final int rows;

  static const List<FieldHeatmapPoint> _simulatedGpsPoints = [
    FieldHeatmapPoint(x: 0.18, y: 0.15, intensity: 0.65),
    FieldHeatmapPoint(x: 0.26, y: 0.18, intensity: 0.72),
    FieldHeatmapPoint(x: 0.34, y: 0.28, intensity: 0.95),
    FieldHeatmapPoint(x: 0.39, y: 0.34, intensity: 0.76),
    FieldHeatmapPoint(x: 0.48, y: 0.42, intensity: 0.99),
    FieldHeatmapPoint(x: 0.55, y: 0.46, intensity: 0.83),
    FieldHeatmapPoint(x: 0.62, y: 0.38, intensity: 0.86),
    FieldHeatmapPoint(x: 0.69, y: 0.32, intensity: 0.91),
    FieldHeatmapPoint(x: 0.72, y: 0.24, intensity: 0.69),
    FieldHeatmapPoint(x: 0.60, y: 0.20, intensity: 0.61),
    FieldHeatmapPoint(x: 0.51, y: 0.28, intensity: 0.76),
    FieldHeatmapPoint(x: 0.42, y: 0.38, intensity: 0.82),
    FieldHeatmapPoint(x: 0.36, y: 0.44, intensity: 0.78),
    FieldHeatmapPoint(x: 0.28, y: 0.54, intensity: 0.71),
    FieldHeatmapPoint(x: 0.24, y: 0.67, intensity: 0.86),
    FieldHeatmapPoint(x: 0.32, y: 0.71, intensity: 0.95),
    FieldHeatmapPoint(x: 0.45, y: 0.76, intensity: 0.77),
    FieldHeatmapPoint(x: 0.57, y: 0.74, intensity: 0.92),
    FieldHeatmapPoint(x: 0.63, y: 0.66, intensity: 0.88),
    FieldHeatmapPoint(x: 0.70, y: 0.58, intensity: 0.79),
    FieldHeatmapPoint(x: 0.66, y: 0.52, intensity: 0.87),
    FieldHeatmapPoint(x: 0.51, y: 0.64, intensity: 0.84),
    FieldHeatmapPoint(x: 0.37, y: 0.60, intensity: 0.73),
    FieldHeatmapPoint(x: 0.20, y: 0.51, intensity: 0.67),
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: AspectRatio(
        aspectRatio: 68 / 105,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: Colors.white24),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.22),
                blurRadius: 14,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          clipBehavior: Clip.antiAlias,
          child: CustomPaint(
            painter: FieldHeatmapPainter(
              points: points ?? _simulatedGpsPoints,
              columns: columns,
              rows: rows,
            ),
          ),
        ),
      ),
    );
  }
}

class FieldHeatmapPainter extends CustomPainter {
  FieldHeatmapPainter({
    required this.points,
    required this.columns,
    required this.rows,
  });

  final List<FieldHeatmapPoint> points;
  final int columns;
  final int rows;

  static const List<Color> _heatPalette = [
    Color(0xFF212121),
    Color(0xFF6B7280),
    Color(0xFF9F1239),
    Color(0xFFDC2626),
    Color(0xFFEF4444),
    Color(0xFFFF0000),
  ];

  Color _colorForHeat(double normalizedValue) {
    if (normalizedValue <= 0) {
      return Colors.transparent;
    }

    final scaledValue = normalizedValue * (_heatPalette.length - 1);
    final index = scaledValue.floor();
    final localValue = scaledValue - index;

    if (index >= _heatPalette.length - 1) {
      return _heatPalette.last;
    }

    return Color.lerp(
      _heatPalette[index],
      _heatPalette[index + 1],
      localValue,
    )!;
  }

  @override
  void paint(Canvas canvas, Size size) {
    final fieldGradient = const LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [
        Color(0xFF666666),
        Color(0xFF5A5A5A),
        Color(0xFF494949),
      ],
    );

    final fieldPaint = Paint()
      ..shader = fieldGradient.createShader(Offset.zero & size);
    canvas.drawRect(Offset.zero & size, fieldPaint);

    final borderPaint = Paint()
      ..color = Colors.white.withValues(alpha: 0.72)
      ..style = PaintingStyle.stroke
      ..strokeWidth = math.max(1.8, size.width * 0.0028);
    canvas.drawRect(Offset.zero & size, borderPaint);

    final midX = size.width / 2;
    final midY = size.height / 2;
    final cellWidth = size.width / columns;
    final cellHeight = size.height / rows;

    final centerLinePaint = Paint()
      ..color = Colors.white.withValues(alpha: 0.45)
      ..style = PaintingStyle.stroke
      ..strokeWidth = math.max(1.2, size.width * 0.0016);
    canvas.drawLine(
      Offset(0, midY),
      Offset(size.width, midY),
      centerLinePaint,
    );

    final counts = List.generate(rows, (_) => List<double>.filled(columns, 0));
    double maxCount = 0;

    for (final point in points) {
      final col = (point.x * columns).floor().clamp(0, columns - 1);
      final row = (point.y * rows).floor().clamp(0, rows - 1);
      final weightedValue = 1 + (point.intensity * 2.0);
      counts[row][col] += weightedValue;
      if (counts[row][col] > maxCount) {
        maxCount = counts[row][col];
      }
    }

    for (var row = 0; row < rows; row++) {
      for (var col = 0; col < columns; col++) {
        final count = counts[row][col];
        if (count <= 0) {
          continue;
        }

        final normalized = count / math.max(maxCount, 1.0);
        final cellRect = Rect.fromLTWH(
          col * cellWidth,
          row * cellHeight,
          cellWidth,
          cellHeight,
        );

        final cellFill = Paint()..color = _colorForHeat(normalized);
        canvas.drawRect(cellRect, cellFill);
      }
    }

    final penaltyWidth = size.width * 0.42;
    final penaltyHeight = size.height * 0.15;
    final topPenaltyRect = Rect.fromLTWH(
      midX - (penaltyWidth / 2),
      0,
      penaltyWidth,
      penaltyHeight,
    );
    final bottomPenaltyRect = Rect.fromLTWH(
      midX - (penaltyWidth / 2),
      size.height - penaltyHeight,
      penaltyWidth,
      penaltyHeight,
    );

    final penaltyStroke = Paint()
      ..color = Colors.white.withValues(alpha: 0.42)
      ..style = PaintingStyle.stroke
      ..strokeWidth = math.max(1.2, size.width * 0.0018);

    canvas.drawRect(topPenaltyRect, penaltyStroke);
    canvas.drawRect(bottomPenaltyRect, penaltyStroke);

    final goalWidth = size.width * 0.18;
    final goalHeight = size.height * 0.07;
    final topGoalRect = Rect.fromLTWH(
      midX - (goalWidth / 2),
      0,
      goalWidth,
      goalHeight,
    );
    final bottomGoalRect = Rect.fromLTWH(
      midX - (goalWidth / 2),
      size.height - goalHeight,
      goalWidth,
      goalHeight,
    );

    final goalStroke = Paint()
      ..color = Colors.white.withValues(alpha: 0.48)
      ..style = PaintingStyle.stroke
      ..strokeWidth = math.max(1.1, size.width * 0.0016);

    canvas.drawRect(topGoalRect, goalStroke);
    canvas.drawRect(bottomGoalRect, goalStroke);

    final centerCirclePaint = Paint()
      ..color = Colors.white.withValues(alpha: 0.38)
      ..style = PaintingStyle.stroke
      ..strokeWidth = math.max(1.0, size.width * 0.0014);
    canvas.drawCircle(Offset(midX, midY), math.min(size.width, size.height) * 0.09, centerCirclePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
