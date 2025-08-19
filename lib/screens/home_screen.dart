import 'package:flutter/material.dart';

import '../services/auth_service.dart';
import 'signin_screen.dart';

class HomeScreen extends StatelessWidget {
  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("MegaMart Home"),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () async {
              await _authService.signOut();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => SignInScreen()),
              );
            },
          ),
        ],
      ),
      body: Center(child: Text("Welcome to MegaMart!")),
    );
  }
}
