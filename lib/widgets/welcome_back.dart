import 'package:flutter/material.dart';

class WelcomeBackText extends StatefulWidget {
  @override
  _WelcomeBackTextState createState() => _WelcomeBackTextState();
}

class _WelcomeBackTextState extends State<WelcomeBackText>
    with TickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _opacityAnimation;
  late final Animation<double> _sizeAnimation;

  @override
  void initState() {
    super.initState();

    // Animation Controller
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    // Opacity Animation
    _opacityAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    // Size Animation
    _sizeAnimation = Tween<double>(begin: 20, end: 30).animate(
      CurvedAnimation(parent: _controller, curve: Curves.elasticOut),
    );

    // Start the animations
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Opacity(
          opacity: _opacityAnimation.value,
          child: Text(
            'Welcome Back !  ',
            style: TextStyle(
              fontFamily: 'Cassandra',
              fontSize: _sizeAnimation.value - 3,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              shadows: [
                Shadow(
                  blurRadius: 4.0,
                  color: Colors.black54,
                  offset: Offset(2.0, 2.0),
                ),
                Shadow(
                  blurRadius: 8.0,
                  color: const Color.fromARGB(255, 71, 71, 68).withOpacity(0.9),
                  offset: Offset(0.0, 0.0),
                ),
              ],
            ),
            textAlign: TextAlign.center,
          ),
        );
      },
    );
  }
}
