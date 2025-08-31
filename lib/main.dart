import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'firebase_options.dart'; // flutterfire configure এ জেনারেট হওয়া ফাইল
import 'screens/splash_screen.dart';
import 'theme/app_theme.dart'; // 👈 তোমার custom theme import করো

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // ✅ Initialize Firebase
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MegaMart',

      // 👇 এখানে custom theme use হচ্ছে
      theme: AppTheme.lightTheme,

      // চাইলে পরে darkTheme ও add করতে পারো
      // darkTheme: AppTheme.darkTheme,
      // themeMode: ThemeMode.system, // device অনুযায়ী light/dark switch হবে
      home: SplashScreen(),
    );
  }
}
