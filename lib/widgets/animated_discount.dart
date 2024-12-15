import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AnimatedDiscount extends StatefulWidget {
  final double targetValue;

  const AnimatedDiscount({Key? key, required this.targetValue})
      : super(key: key);

  @override
  _AnimatedDiscountState createState() => _AnimatedDiscountState();
}

class _AnimatedDiscountState extends State<AnimatedDiscount>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _discountAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 5),
      vsync: this,
    );

    _discountAnimation = Tween<double>(begin: 0, end: widget.targetValue)
        .animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    ));

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        AnimatedBuilder(
          animation: _discountAnimation,
          builder: (context, child) {
            return Text(
              "\$ ${_discountAnimation.value.toStringAsFixed(2)}",
              style: GoogleFonts.sora(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: const Color(0xFFC52127),
              ),
            );
          },
        ),
      ],
    );
  }
}
