import 'package:SentinelVPN/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import '../screens/home_screen.dart';

class AnimationScreen extends StatefulWidget {
  @override
  _AnimationScreenState createState() => _AnimationScreenState();
}

class _AnimationScreenState extends State<AnimationScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    );
    _animationController.forward();
    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Get.offAll(() => HomeScreen());
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
      backgroundColor: Colors.white,
      body: Center(
        child: Lottie.asset(
          // Replace with your Lottie animation asset path
          'assets/animations/animation.json',
          width: sz.width * .6,
          height: sz.height * .6,
          controller: _animationController,
          onLoaded: (composition) {
            _animationController
              ..duration = composition.duration
              ..forward();
          },
        ),
      ),
    );
  }
}
