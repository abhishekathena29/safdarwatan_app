import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

/// A global, low-opacity grain overlay that gives surfaces a tactile,
/// paper-like quality (DESIGN.md → Elevation & Depth → Subtle Grain).
///
/// The original design uses a noise PNG; here we paint deterministic
/// speckles so no network asset is required.
class GrainOverlay extends StatelessWidget {
  const GrainOverlay({super.key, this.opacity = 0.04});

  final double opacity;

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Opacity(
        opacity: opacity,
        child: CustomPaint(
          size: Size.infinite,
          painter: _GrainPainter(),
        ),
      ),
    );
  }
}

class _GrainPainter extends CustomPainter {
  // Fixed seed → stable grain (no flicker on rebuild).
  static final math.Random _rng = math.Random(42);
  static final List<Offset> _points = List.generate(
    1400,
    (_) => Offset(_rng.nextDouble(), _rng.nextDouble()),
  );

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = AppColors.onSurface;
    for (final p in _points) {
      canvas.drawCircle(
        Offset(p.dx * size.width, p.dy * size.height),
        0.6,
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant _GrainPainter oldDelegate) => false;
}
