import 'package:SentinelVPN/animations/page_transitions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../animations/animation_screen.dart';
import '../main.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 3),
    );
    _animationController.forward();
    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        // Get.off(() => AnimationScreen());
        Get.off(
          () => FadeAnimationScreen(child: AnimationScreen()),
        );
      }
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //initializing media query (for getting device screen size)
    sz = MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/icons/icon.png'),
            // Replace with your image asset path
            SizedBox(height: sz.height * 0.1),
            Text(
              'Sentinel VPN',
              style: GoogleFonts.ubuntu(
                  color: Theme.of(context).lightText,
                  fontSize: 20,
                  fontWeight: FontWeight.w300,
                  letterSpacing: 1),
            ),
          ],
        ),
      ),
    );
  }
}
