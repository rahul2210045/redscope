import 'package:flutter/material.dart';
import 'dart:async';
import 'package:redscope_assignment/screens/home/ui/Home_Screen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController _iconController;
  late Animation<double> _iconAnimation;

  @override
  void initState() {
    super.initState();

    // Set up animation controller for the icon
    _iconController = AnimationController(
      duration: Duration(milliseconds: 1000),
      vsync: this,
    );

    _iconAnimation = CurvedAnimation(
      parent: _iconController,
      curve: Curves.easeInOut,
    );

    _iconController.repeat(reverse: true);

    // Navigate to the HomeScreen after 2 seconds
    Timer(Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
    });
  }

  @override
  void dispose() {
    _iconController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF4A90E2), Color(0xFF56CCF2)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ScaleTransition(
                scale: _iconAnimation,
                child: Icon(
                  Icons.photo_library,
                  size: screenWidth * 0.3,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: screenHeight * 0.04),
              Text(
                'Welcome to FlutterApp',
                style: TextStyle(
                  fontSize: screenWidth * 0.07,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Roboto',
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'Your photos, beautifully organized',
                style: TextStyle(
                  fontSize: screenWidth * 0.04,
                  color: Colors.white70,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
