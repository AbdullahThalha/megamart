import 'package:flutter/material.dart';

import '../services/auth_service.dart';
import 'home_screen.dart';
import 'signin_screen.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final AuthService _authService = AuthService();

  String _name = '';
  String _email = '';
  String _password = '';
  bool _isLoading = false;

  Future<void> _signUp() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      setState(() => _isLoading = true);

      try {
        final user = await _authService.signUp(_email, _password, _name);
        if (user != null) {
          // Auto login successful, navigate to Home
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => HomeScreen()),
          );
        }
      } catch (e) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Sign up failed: $e')));
      } finally {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Sign Up")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Name
              TextFormField(
                decoration: InputDecoration(labelText: "Name (optional)"),
                onSaved: (value) => _name = value ?? '',
              ),
              // Email
              TextFormField(
                decoration: InputDecoration(labelText: "Email"),
                validator: (value) =>
                    value!.isEmpty ? "Enter your email" : null,
                onSaved: (value) => _email = value!,
              ),
              // Password
              TextFormField(
                decoration: InputDecoration(labelText: "Password"),
                obscureText: true,
                validator: (value) => value!.length < 6
                    ? "Password must be at least 6 characters"
                    : null,
                onSaved: (value) => _password = value!,
              ),
              SizedBox(height: 20),
              // Sign Up Button / Loader
              _isLoading
                  ? CircularProgressIndicator()
                  : ElevatedButton(onPressed: _signUp, child: Text("Sign Up")),
              SizedBox(height: 20),
              // Link to Sign In
              TextButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (_) => SignInScreen()),
                  );
                },
                child: Text("Already have an account? Sign in"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
