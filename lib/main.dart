import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:prioritize/controllers/task_controller.dart';
import 'package:prioritize/firebase_options.dart';
import 'package:prioritize/ui/login_screen.dart';
import 'package:prioritize/ui/main_screen.dart';
import 'package:prioritize/ui/register_screen.dart';
import 'package:prioritize/ui/splash_screen.dart';
import 'package:prioritize/services/auth_gate.dart';
import 'package:prioritize/utils/Theme.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: 'https://kojohbezcwgzzdibqfyi.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Imtvam9oYmV6Y3dnenpkaWJxZnlpIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDU3OTA5NjIsImV4cCI6MjA2MTM2Njk2Mn0.0eguRRnDQE7_LkYamMetdo9dYdhJ-Go0DcQyPmicSV4',
  );
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(
    MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => TaskController())],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Prioritize',
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
