import 'package:flutter/material.dart';

class IntroBackground extends StatelessWidget {
  const IntroBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _SplashPainter(),
      size: Size.infinite,
      child: const SizedBox.expand(),
    );
  }
}

class _SplashPainter extends CustomPainter {
  static const _bg = Color(0xFF03030B);
  static const _purple = Color(0xFF6C63FF);

  @override
  void paint(Canvas canvas, Size size) {
    _drawBackground(canvas, size);
    _drawGlows(canvas, size);
    _drawStars(canvas, size);
    _drawCurves(canvas, size);
    _drawDots(canvas, size);
  }

  void _drawBackground(Canvas canvas, Size size) {
    canvas.drawRect(
      Rect.fromLTWH(0, 0, size.width, size.height),
      Paint()..color = _bg,
    );
  }

  void _drawGlows(Canvas canvas, Size size) {
    final glows = [
      // top-left
      (Offset(size.width * .15, size.height * .10), 260.0, .20),
      // bottom-right
      (Offset(size.width * .85, size.height * .88), 300.0, .18),
      // center subtle
      (Offset(size.width * .50, size.height * .50), 200.0, .06),
    ];

    for (final (center, radius, opacity) in glows) {
      canvas.drawCircle(
        center,
        radius,
        Paint()
          ..shader = RadialGradient(
            colors: [_purple.withOpacity(opacity), Colors.transparent],
          ).createShader(Rect.fromCircle(center: center, radius: radius)),
      );
    }
  }

  void _drawStars(Canvas canvas, Size size) {
    final positions = [
      (0.08, 0.22),
      (0.20, 0.05),
      (0.35, 0.14),
      (0.55, 0.08),
      (0.72, 0.18),
      (0.90, 0.06),
      (0.80, 0.35),
      (0.92, 0.55),
      (0.05, 0.45),
      (0.12, 0.68),
      (0.60, 0.72),
      (0.42, 0.88),
      (0.88, 0.76),
      (0.30, 0.95),
      (0.65, 0.96),
    ];

    final dimPaint = Paint()..color = _purple.withOpacity(.25);
    final brightPaint = Paint()..color = _purple.withOpacity(.55);

    for (final (i, (x, y)) in positions.indexed) {
      final offset = Offset(size.width * x, size.height * y);
      final bright = i % 3 == 0;
      canvas.drawCircle(
        offset,
        bright ? 1.8 : 1.2,
        bright ? brightPaint : dimPaint,
      );
    }
  }

  void _drawCurves(Canvas canvas, Size size) {
    // primary curve
    final primary = Path()
      ..moveTo(size.width * .02, size.height * .80)
      ..cubicTo(
        size.width * .28,
        size.height * .68,
        size.width * .68,
        size.height * .92,
        size.width * .98,
        size.height * .80,
      );

    // secondary curve (offset lower)
    final secondary = Path()
      ..moveTo(size.width * .02, size.height * .88)
      ..cubicTo(
        size.width * .32,
        size.height * .76,
        size.width * .72,
        size.height * .98,
        size.width * .98,
        size.height * .88,
      );

    canvas.drawPath(
      primary,
      Paint()
        ..color = _purple.withOpacity(.35)
        ..strokeWidth = 1.5
        ..style = PaintingStyle.stroke,
    );

    canvas.drawPath(
      secondary,
      Paint()
        ..color = _purple.withOpacity(.12)
        ..strokeWidth = 1.0
        ..style = PaintingStyle.stroke,
    );
  }

  void _drawDots(Canvas canvas, Size size) {
    final dots = [(0.18, 0.80), (0.78, 0.88), (0.50, 0.75), (0.92, 0.82)];

    final blurPaint = Paint()
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 10)
      ..color = _purple.withOpacity(.8);

    final solidPaint = Paint()..color = _purple;

    for (final (x, y) in dots) {
      final center = Offset(size.width * x, size.height * y);
      canvas.drawCircle(center, 6, blurPaint);
      canvas.drawCircle(center, 2.5, solidPaint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
