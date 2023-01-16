import 'package:educational_app/src/configs/themes/app_colors.dart';
import 'package:flutter/material.dart';

class BackgroundDecoration extends StatelessWidget {
  final Widget child;
  final bool showGradient;

  const BackgroundDecoration({
    super.key,
    required this.child,
    this.showGradient = false,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: Container(
            decoration: BoxDecoration(
              color: showGradient ? null : Theme.of(context).primaryColor,
              gradient: showGradient ? mainGradient() : null,
            ),
            child: CustomPaint(
              painter: BackgroundPainter(),
            ),
          ),
        ),
        Positioned(
          child: child,
        ),
      ],
    );
  }
}

class BackgroundPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    /// Paint 객체에 white 색상 할당
    Paint paint = Paint()..color = Colors.white.withOpacity(0.1);

    final path_1 = Path();
    path_1.moveTo(0, 0);
    path_1.lineTo(size.width * 0.2, 0);
    path_1.lineTo(0, size.height * 0.4);
    path_1.close();

    final path_2 = Path();
    path_2.moveTo(size.width, 0);
    path_2.lineTo(size.width * 0.8, 0);
    path_2.lineTo(size.width * 0.2, size.height);
    path_2.lineTo(size.width, size.height);
    path_2.close();

    canvas.drawPath(path_1, paint);
    canvas.drawPath(path_2, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
