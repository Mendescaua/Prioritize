import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:prioritize/firebase_options.dart';
import 'package:prioritize/ui/login_screen.dart';
import 'package:prioritize/ui/main_screen.dart';
import 'package:prioritize/ui/register_screen.dart';
import 'package:prioritize/ui/splash_screen.dart';
import 'package:prioritize/services/auth_gate.dart';
import 'package:prioritize/utils/Theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setSystemUIOverlayStyle(
  //   SystemUiOverlayStyle(systemNavigationBarColor: Cores.background),
  // );
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme: AppBarTheme(backgroundColor: ThemeColor.background),
        scaffoldBackgroundColor: ThemeColor.background,
        fontFamily: 'Poppins',
      ),
      home: const AuthGate(),
      routes: {
        '/splash': (context) => const SplashScreen(),
        '/home': (context) => const MainScreen(),
        '/login': (context) => const LoginScreen(),
        '/register': (context) => const RegisterScreen(),
      },
    );
  }
}
