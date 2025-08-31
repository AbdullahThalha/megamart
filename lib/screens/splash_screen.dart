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
    // Wait 2 seconds for splash animation
    await Future.delayed(const Duration(seconds: 2));

    // Check if user is logged in
    final user = _authService.currentUser;

    if (user != null) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => HomeScreen()),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => SignInScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(
        context,
      ).scaffoldBackgroundColor, // ✅ Theme থেকে background নেবে
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/images/logo.png", width: 120, height: 120),
            const SizedBox(height: 20),
            Text(
              "MegaMart – Shop Smarter",
              style: Theme.of(
                context,
              ).textTheme.headlineMedium, // ✅ Theme এর text style
            ),
            const SizedBox(height: 30),
            CircularProgressIndicator(
              color: Theme.of(context).primaryColor, // ✅ Theme এর primaryColor
            ),
          ],
        ),
      ),
    );
  }
}
