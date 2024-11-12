import 'dart:async';
import 'package:flutter/material.dart';
import 'package:perfection_company/home/ui/user_list_screen.dart';
import 'package:perfection_company/splash/ui/widget/fade_routes.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  bool _isVisible = false;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(begin: 0.6, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
    );

    _startAnimations();

    Timer(
      const Duration(seconds: 3),
      () {
        Navigator.of(context).pushReplacement(
          FadeRoute(page: const UserListScreen()), // Use FadeRoute here
        );
      },
    );
  }

  void _startAnimations() {
    _animationController.forward().then((_) {
      setState(() {
        _isVisible = true; // Trigger fade-in after scale-up
      });
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: Column(
            children: [
              const Spacer(),
              ScaleTransition(
                scale: _scaleAnimation,
                child: AnimatedOpacity(
                  opacity: _isVisible ? 1.0 : 0.0,
                  duration: const Duration(milliseconds: 800),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset(
                        'assets/images/qt=q_95.webp',
                        width: screenWidth * 0.5,
                        height: screenWidth * 0.5,
                      ),
                    ],
                  ),
                ),
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
