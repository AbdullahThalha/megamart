import 'package:flutter/material.dart';

import '../services/auth_service.dart';
import 'home_screen.dart';
import 'signin_screen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final AuthService _authService = AuthService();

  @override
  void initState() {
    super.initState();
    _navigate();
  }

  void _navigate() async {
    // Wait 2-3 seconds for splash animation
    await Future.delayed(const Duration(seconds: 2));

    // Check if user is logged in
    final user = _authService.currentUser;

    if (user != null) {
      // Navigate to Home if logged in
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => HomeScreen()),
      );
    } else {
      // Navigate to Sign-in if not logged in
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => SignInScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/images/logo.png", width: 120, height: 120),
            const SizedBox(height: 20),
            const Text(
              "MegaMart – Shop Smarter",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 30),
            const CircularProgressIndicator(color: Colors.orange),
          ],
        ),
      ),
    );
  }
}
