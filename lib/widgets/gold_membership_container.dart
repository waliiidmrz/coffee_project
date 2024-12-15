import 'package:flutter/material.dart';
import 'dart:math';

class AnimatedGoldMembershipContainer extends StatefulWidget {
  @override
  _AnimatedGoldMembershipContainerState createState() =>
      _AnimatedGoldMembershipContainerState();
}

class _AnimatedGoldMembershipContainerState
    extends State<AnimatedGoldMembershipContainer>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _glowAnimation;
  late Animation<double> _shimmerAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..repeat(reverse: true);

    _glowAnimation = Tween<double>(begin: 0.4, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    _shimmerAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.linear),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        // Pulsating Glow Effect
        AnimatedBuilder(
          animation: _glowAnimation,
          builder: (context, child) {
            return Container(
              width: 315,
              height: 56,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14),
                gradient: RadialGradient(
                  colors: [
                    const Color(0xFFFFD700).withOpacity(_glowAnimation.value),
                    Colors.transparent,
                  ],
                  radius: 2.5,
                ),
              ),
            );
          },
        ),

        // Shimmering Gold Background
        AnimatedBuilder(
          animation: _shimmerAnimation,
          builder: (context, child) {
            return Container(
              width: 315,
              height: 56,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    const Color.fromARGB(255, 248, 200, 67),
                    Color(0xFFFFD700).withOpacity(0.5),
                    const Color(0xFFFAC42E),
                  ],
                  stops: [
                    (_shimmerAnimation.value - 0.3).clamp(0.0, 1.0),
                    (_shimmerAnimation.value).clamp(0.0, 1.0),
                    (_shimmerAnimation.value + 0.3).clamp(0.0, 1.0),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(14),
                boxShadow: [
                  BoxShadow(
                    color: Colors.yellow.withOpacity(0.5),
                    blurRadius: 12,
                    spreadRadius: 2,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
            );
          },
        ),

        // Sparkle Effect
        Positioned.fill(
          child: AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return CustomPaint(
                painter: SparklePainter(
                  shimmerValue: _shimmerAnimation.value,
                  glowValue: _glowAnimation.value,
                ),
              );
            },
          ),
        ),

        // Content
        Container(
          width: 315,
          height: 56,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Icon and Text
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 7.0, right: 15),
                    child: Icon(
                      Icons.card_giftcard,
                      size: 28,
                      color: const Color(0xFFFFE57F),
                      shadows: [
                        Shadow(
                          color: Colors.black.withOpacity(0.5),
                          offset: const Offset(0, 3),
                          blurRadius: 5,
                        ),
                      ],
                    ),
                  ),
                  Text(
                    "Gold Membership Discount Applied",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
              // Navigate to Benefits Page
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/gold-benefits');
                },
                child: const Icon(
                  Icons.arrow_forward_ios,
                  size: 20,
                  color: Colors.black54,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// Custom Painter for Sparkles
class SparklePainter extends CustomPainter {
  final double shimmerValue;
  final double glowValue;

  SparklePainter({required this.shimmerValue, required this.glowValue});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.yellow.withOpacity(glowValue)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 5.0);

    final random = Random();
    for (int i = 0; i < 8; i++) {
      final dx = random.nextDouble() * size.width;
      final dy = random.nextDouble() * size.height;
      canvas.drawCircle(Offset(dx, dy), 2 + random.nextDouble() * 3, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
