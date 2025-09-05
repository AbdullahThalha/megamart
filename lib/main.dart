import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart'; // FlutterFire generated file
import 'providers/cart_provider.dart'; // CartProvider for state management
import 'screens/splash_screen.dart';
import 'theme/app_theme.dart'; // Your custom theme

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(
    MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => CartProvider())],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MegaMart',

      // Apply custom theme
      theme: AppTheme.lightTheme,

      // Splash screen as the first screen
      home: SplashScreen(),
    );
  }
}
